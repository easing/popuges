# frozen_string_literal: true

#
class User::RegisteredConsumer < EDA::Consumer
  version 1 do
    user = User.create_or_update_from_event(event.data)
    CreateWelcomeTask.run!(user: user) if user.role_popug?
  end
end
