class Task::UpdatedConsumer < EDA::Consumer
  version 1 do
    Task.create_or_update_from_event(event.data)
  end
end