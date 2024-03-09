class Ability < ApplicationAbility
  private

  def any_role
    can_read_own_notifications
  end

  def role_administrator
    can_read_notifications
  end

  def can_read_own_notifications
    can :read, Notification, user: user
  end

  def can_read_notifications
    can :read, Notification
  end
end
