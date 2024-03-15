class Ability < ApplicationAbility
  private

  def any_role
    can_read_own_transactions
  end

  def role_administrator
    can_read_users
    can_read_transactions
    can_read_billing_cycles
    can_close_billing_cycles
  end

  def role_accountant
    can_read_users
    can_read_transactions
    can_read_billing_cycles
    can_close_billing_cycles
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

  def can_close_billing_cycles
    can :close, BillingCycle, current: true
  end

  def can_read_billing_cycles
    can :read, BillingCycle
  end
end
