class Ability < ApplicationAbility
  private

  def any_role
  end

  def role_administrator
    can_manage_tasks
  end

  def role_manager
    can_manage_tasks
  end

  def role_accountant
    can_read_tasks
    can_create_tasks
  end

  def role_popug
    can_create_tasks
    can_read_own_tasks
    can_complete_own_tasks
  end

  #

  def can_read_tasks
    can :read, Task
  end

  def can_read_own_tasks
    can :read, Task, assignee: user
  end

  def can_create_tasks
    can [:create], Task
  end

  def can_manage_tasks
    can_read_tasks
    can [:create, :complete, :reassign], Task
  end

  def can_complete_own_tasks
    can [:complete], Task, assignee: user
  end
end
