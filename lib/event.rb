## Базовое событие
class Event
  # @!attribute
  attr_reader :data

  # @param [Object] data данные для передачи в шину событий
  def initialize(data)
    @data = data.as_json
  end

  # Отправить сообщение в указанный топик
  #
  # @param [String|Symbol] topic топик в который нужно отправить сообщение
  # @return [Rdkafka::Producer::DeliveryHandle]
  def stream_to(topic)
    Karafka.producer.produce_async(topic: topic, payload: { event_name: self.class.name, data: data }.to_json)
  end

  # Отправить сообщение в топик по-умолчанию
  #
  # @return [Rdkafka::Producer::DeliveryHandle]
  def stream
    stream_to(self.class.topic)
  end

  # Топик по-умолчанию
  #
  # @return [String]
  def self.topic
    Rails.application.class.name.deconstantize.downcase
  end
end
