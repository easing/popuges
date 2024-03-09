class Ability < ApplicationAbility
  private

  def any_role
    # ничего не может
  end

  def role_popug
    can [:read, :complete], Task, assignee: user
  end

  def role_administrator
    can_read_tasks
    can_manage_tasks
  end

  def role_manager
    can_manage_tasks
  end

  def accountant
    can_read_tasks
  end

  def can_read_tasks
    can :read, Task
  end

  def can_manage_tasks
    can [:create, :complete], Task
  end
end
