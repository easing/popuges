# frozen_string_literal: true

##
class UserRoleChangedHandler < Handler
  def call
    UserUpdatedHandler.new(data).call
  end
end
