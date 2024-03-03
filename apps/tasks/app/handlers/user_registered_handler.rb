# frozen_string_literal: true

#
class UserRegisteredHandler < ::Handler
  def call
    user = User.create_or_update_from_event(data)

    create_welcome_task(assigned_to: user) if user.role_popug?
  end

  private

  def create_welcome_task(**kwargs)
    task = Task.create!(subject: "Добро пожаловать в Попугаицу", **kwargs)
    TaskAssigned.new(task).stream
  end
end
