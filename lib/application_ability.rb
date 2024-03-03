##
class ApplicationAbility
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    call if user.present?
  end

  def call
    raise NotImplementedError
  end
end
