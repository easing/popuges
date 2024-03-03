class Ability < ApplicationAbility
  def call
    if user.role_administrator?
      can :read, Transaction
    else
      can :read, Transaction, user: user
    end
  end
end
