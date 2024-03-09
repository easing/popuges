# frozen_string_literal: true

# Наивный стриминг изменений моделей в общую шину событий
module AutoStreamable
  extend ActiveSupport::Concern

  included do
    # Если запись изменилась, отправляем сообщение в шину событий
    after_commit :stream_changes, if: :saved_changes?

    # Сообщить об изменении записи
    #
    # Определяем название события из класса модели и совершённого действия (например, `UserUpdated`)
    # Если у нас нет специального класса для произошедшего события, не отправляем никаких сообщений
    # Если класс для события есть, отправляем сообщение в дефолтный для нашего приложения топик, канал или его аналог
    #
    # @return [Rdkafka::Producer::DeliveryHandle]
    def stream_changes
      event_name = "#{self.class.name.gsub('::', '')}#{transaction_action}"
      event_class = event_name.safe_constantize

      return if event_class.nil?
      return unless respond_to?(:public_id)

      event_class.new(as_event_data).stream
    end

    # Совершённое с записью действие
    # @return [String] 'Created'|'Updated'|'Destroyed'
    def transaction_action
      if transaction_include_any_action?([:create])
        "Created"
      elsif transaction_include_any_action?([:destroy])
        "Destroyed"
      else
        "Updated"
      end
    end
  end
end
