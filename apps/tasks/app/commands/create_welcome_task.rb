class CreateWelcomeTask < ApplicationInteraction
  record :user

  def execute
    task = Task.create!(subject: "Добро пожаловать в Попугаицу", assignee: user )
    stream TaskAdded, task.as_event_data
  end

  private

  def random_popug
    User.role_popug.reorder(Arel.sql("RANDOM()")).first
  end
end