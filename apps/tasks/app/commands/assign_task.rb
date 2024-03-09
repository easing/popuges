class AssignTask < ApplicationInteraction
  record :task
  record :user

  # @return [TrueClass,FalseClass]
  def execute
    task.update!(assignee: user)
  end
end