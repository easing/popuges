# frozen_string_literal: true

##
class Task::UpdatedConsumer < EDA::Consumer
  version(1) { Task.create_or_update_from_event(event.data) }
  version(2) { Task.create_or_update_from_event(event.data) }
end
