class Ability < ApplicationAbility
  def call
    case user.role
    when User.roles[:administrator]
      can [:read, :edit, :update], User
    when User.roles[:manager]
      can [:read], User
    else
      can [:read, :edit, :update], User, id: user.id
    end
  end
end
