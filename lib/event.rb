## Базовое событие
class Event
  cattr_accessor :producer, :schema_loader
  attr_reader :errors

  self.producer = Karafka.producer

  def version = 1

  def schema_path = Rails.root.join("../../schemas", self.class.name.underscore, "#{version}.json")

  def topic = raise NotImplementedError

  def initialize(params, version: 1)
    @params = params.to_h.with_indifferent_access
    @version = version
  end

  def params = @params.as_json

  def payload
    {
      event_id: SecureRandom.uuid,
      event_name: self.class.name,
      event_time: Time.current.to_s,
      event_version: version,
      producer: Rails.application.class.name.deconstantize.downcase,
      data: params
    }
  end

  def as_json
    {
      topic: topic,
      payload: payload.to_json
    }
  end

  def valid?
    validate
  end

  def validate
    unless defined? @valid
      @errors = JSON::Validator.fully_validate(File.read(schema_path), payload)
      @valid = @errors.empty?
    end

    @valid
  end

  def stream
    if valid?
      producer.produce_async(as_json)
    else
      raise "Invalid event #{self.class.name}.#{version} (#{payload.inspect})"
    end
  end

  def self.stream_batch(events)
    messages = events.filter_map do |event_params|
      event = self.class.new(event_params)
      next unless event.valid?
      event.as_json
    end

    self.producer.produce_many_async(messages)
  end
end
