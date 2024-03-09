class Ability < ApplicationAbility
  private

  def any_role
    can_read_own_transactions
  end

  def role_administrator
    can_read_transactions
    can_read_users
  end

  #

  def can_read_own_transactions
    can :read, Transaction, user: user
  end

  def can_read_transactions
    can :read, Transaction
  end

  def can_read_users
    can :read, User
  end
end
