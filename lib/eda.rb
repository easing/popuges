##
module EDA
  cattr_accessor :producer, :registry, :serializer, :service_name
  attr_reader :errors

  self.producer = Karafka.producer
  self.registry = EDA::SchemaRegistry.new(Rails.root.join("../../schemas"))

  self.service_name = Rails.application.class.name&.deconstantize&.downcase

  # @param [EDA::Event] event
  def self.stream(event)
    if event.valid?
      producer.produce_async(topic: event.topic, payload: event.payload.to_json)
    else
      Rails.error.report "INVALID EVENT => #{self.class.name}.#{event.version} => payload: (#{event.payload.inspect}), errors: (#{event.errors.join(";")})"
    end
  end

  # @param [[EDA::Event]] events
  def self.stream_batch(events)
    valid_events = events.select(&:valid?)

    messages = valid_events.map do |event|
      { topic: event.topic, payload: event.payload.to_json }
    end

    producer.produce_many_async(messages)
  end

  # @param [Hash] payload
  def self.consume(payload)
    event = EDA::Event.from_payload(payload)

    debug_info = "#{Rails.application.class.name}: #{event.name}, #{event.payload.inspect}"
    Rails.logger.debug debug_info

    unless event.valid?
      Rails.logger.error "INVALID EVENT => #{debug_info}"
      return
    end

    event_name = event.payload["event_name"]
    handler_class = "#{event_name}Consumer".safe_constantize

    return unless handler_class

    # Если у задачи есть обработчик, запускаем его
    handler_class.new(event).call
  end

  # Привести данные к схеме события
  def self.serialize(payload)
    payload = payload.with_indifferent_access
    schema = registry.schema_for(payload["event_name"], version: payload["event_version"])
    serializer = JSON::Schema::Serializer.new JsonRefs.(schema.schema)

    serializer.serialize(payload)
  end

  # @param [EDA::Event] event
  def self.validate(event)
    schema = registry.schema_for(event.name, version: event.version)

    raise NotImplementedError, "No schema found for #{event.name}.v#{event.version}" unless schema

    JSON::Validator.fully_validate(schema.schema, event.payload)
  rescue => e
    [e.message]
  end
end