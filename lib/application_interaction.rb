class ApplicationInteraction < ActiveInteraction::Base
  include ActiveInteraction::Extras::All

  # @param [Class] event_class класс события
  # @param [Object] data даные для передачи в событии
  def stream(event_class, data)
    event_class.new(data).stream
  end
end
