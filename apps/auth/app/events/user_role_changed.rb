# frozen_string_literal: true

class UserRoleChanged < Event
  def topic = "users_permissions"

  def params
    {
      public_id: @params["public_id"],
      name: @params["name"],
      role: @params["role"]
    }
  end
end
