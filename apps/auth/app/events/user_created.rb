# frozen_string_literal: true

class UserCreated < Event
  def topic = "users_data_stream"

  def params
    {
      public_id: @params["public_id"],
      name: @params["name"],
      role: @params["role"]
    }
  end
end
