# frozen_string_literal: true

##
class UserRoleChangedHandler < Handler
  def call
    User.create_or_update_from_event(data)
  end
end
