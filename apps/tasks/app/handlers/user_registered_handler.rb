# frozen_string_literal: true

#
class UserRegisteredHandler < ::Handler
  def call
    user = User.create_or_update_from_event(data)
    CreateWelcomeTask.run!(user: user) if user.role_popug?
  end
end
