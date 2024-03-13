# frozen_string_literal: true

class User::RoleChanged < EDA::Event
  topic :users_permissions
end
