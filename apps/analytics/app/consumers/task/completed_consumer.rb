# frozen_string_literal: true

#
class Task::CompletedConsumer < EDA::Consumer
  version 1 do
    Task.create_or_update_from_event(event.data)
  end
end
