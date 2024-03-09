class Ability < ApplicationAbility
  private

  # Roles
  def any_role
    can_manage_self
  end

  def role_administrator
    can_read_users
    can_manage_users
  end

  def role_manager
    can_read_users
  end

  # Permissions
  def can_manage_self
    can [:read, :edit, :update], User, id: user.id
  end

  def can_read_users
    can [:read], User
  end

  def can_manage_users
    can [:read, :edit, :update, :create], User
  end
end
