# frozen_string_literal: true

class UserRegistered < Event
  def topic = "users_registrations"

  def params
    {
      public_id: @params["public_id"],
      name: @params["name"],
      role: @params["role"]
    }
  end
end
