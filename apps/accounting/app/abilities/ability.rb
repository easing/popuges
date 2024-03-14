class Ability < ApplicationAbility
  private

  def any_role
    can_read_own_transactions
  end

  def role_administrator
    can_read_transactions
    can_read_users
  end

  def can_read_own_transactions
    can :read, BillingCycle, user: user
    can :read, Transaction, billing_cycle: { user: user }
  end

  def can_read_transactions
    can :read, Transaction
  end

  def can_read_users
    can :read, User
  end
end
