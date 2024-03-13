class CreateWelcomeTask < ApplicationInteraction
  record :user

  def execute
    task = Task.create!(subject: "Добро пожаловать в Попугаицу", assignee: user)
    EDA.stream Task::Added.new(task.as_event_data)
  end
end