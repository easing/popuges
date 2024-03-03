## Базовый обработчик события
class Handler
  # @!attribute
  attr_reader :data

  # @param [String] payload данные события
  def initialize(data)
    @data = data
  end

  # Обработать событие
  def call
    raise NotImplementedError
  end

  def self.run(message)
    payload = message.payload

    event_name = payload["event_name"]

    handler_class = "#{event_name}Handler".safe_constantize

    # Если у задачи есть обработчик, запускаем его
    return handler_class.new(payload["data"]).call if handler_class

    # Выходим, если нет обработчика и это не CUD-событие
    return unless event_name =~ /\ACreated|Updated|Destroyed\z/

    model_class = event_name.gsub(/\ACreated|Updated|Destroyed\z/, "").safe_constantize
    return unless model_class

    if event_name =~ /Destroyed\z/
      model_class.destroy(payload.data.id)
    else
      # Обновляем данные записи
      model_class.create_or_update_from_event(payload["data"])
    end
  end
end
