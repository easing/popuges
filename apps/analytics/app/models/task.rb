# Задача
class Task < ApplicationRecord
  belongs_to :assigned_to, class_name: "User"
end
