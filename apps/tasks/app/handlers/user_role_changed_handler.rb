# frozen_string_literal: true

##
class UserRoleChangedHandler < Handler
  def call
    user = User.create_or_update_from_event(data)

    AddTask.run!(subject: "Задачка в подарок", user: user) if user.role_popug?

    user
  end
end
