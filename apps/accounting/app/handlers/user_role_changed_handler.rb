# frozen_string_literal: true

##
class UserRoleChangedHandler < Handler
  def call
    user = User.create_or_update_from_event(data)
    user.update!(role: data["role"].to_s)
  end
end
