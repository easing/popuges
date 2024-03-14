# frozen_string_literal: true

##
class User::RoleChangedConsumer < EDA::Consumer
  version 1 do
    User.create_or_update_from_event(event.data)
  end
end
