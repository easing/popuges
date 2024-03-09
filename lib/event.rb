## Базовое событие
class Event
  cattr_accessor :producer

  @@producer = Karafka.producer

  def topic
    raise NotImplementedError
  end

  def initialize(params)
    @params = params.to_h.with_indifferent_access
  end

  def params
    @params.as_json
  end

  def as_json
    {
      topic: topic,
      payload: {
        id: SecureRandom.uuid,
        event_name: self.class.name,
        data: params
      }.to_json
    }
  end

  def stream
    @@producer.produce_async(as_json)
  end

  def self.stream_batch(events)
    @@producer.produce_many_async(
      events.map { |event_params| self.class.new(event_params).as_json }
    )
  end
end
