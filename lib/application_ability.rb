##
class ApplicationAbility
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    return if user.blank?

    if respond_to?("role_#{user.role}", true)
      send("role_#{user.role}")
    else
      any_role
    end
  end

  private

  def any_role
    raise NotImplementedError
  end
end
