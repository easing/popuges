require_relative "./eda/schema_registry"
require_relative "./eda/event"
require_relative "./eda/consumer"

##
module EDA
  cattr_accessor :producer, :registry
  attr_reader :errors

  self.producer = Karafka.producer
  self.registry = EDA::SchemaRegistry.new(Rails.root.join("../../schemas"))

  def self.stream(event)
    if event.valid?
      producer.produce_async(event.as_json)
    else
      Rails.error.report "Invalid event #{self.class.name}.#{event.version} => payload: (#{event.payload.inspect}), errors: (#{event.errors.join(";")})"
    end
  end

  def self.stream_batch(events)
    messages = events.select(&:valid?).map(&:as_json)
    producer.produce_many_async(messages)
  end

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
end