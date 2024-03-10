## Базовый обработчик события
class Handler
  # @!attribute
  attr_reader :data

  def self.version = 1

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
    event_version = payload["event_version"]

    Rails.logger.debug "#{Rails.application.class.name}: #{event_name}.v#{event_version}, #{payload.inspect}"

    return unless version == event_version

    handler_class = "#{event_name}Handler".safe_constantize

    # Если у задачи есть обработчик, запускаем его
    return handler_class.new(payload["data"]).call if handler_class

    # Выходим, если нет обработчика и это не CUD-событие
    return unless /(Created|Updated|Destroyed)\z/.match?(event_name)

    model_class = event_name.gsub(/(Created|Updated|Destroyed)\z/, "").safe_constantize
    return unless model_class

    if /Destroyed\z/.match?(event_name)
      model_class.find_by(public_id: payload["data"].public_id)
    else
      # Обновляем данные записи
      model_class.create_or_update_from_event(payload["data"])
    end
  end

  def stream(event_class, event_data)
    event_class.new(event_data).stream
  end
end
