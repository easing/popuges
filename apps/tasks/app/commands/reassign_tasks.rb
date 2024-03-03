## Назначить незакрытые задачи на случайных попугов
class ReassignTasks < ApplicationInteraction
  def execute
    User.role_popug.find_each do |user|
      AssignTask.run!(user: user)
    end
  end
end