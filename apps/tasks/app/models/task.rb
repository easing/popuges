# == Schema Information
#
# Table name: tasks
#
#  id             :uuid             not null, primary key
#  subject        :string           not null
#  assigned_to_id :uuid
#  completed_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Задача
class Task < ApplicationRecord
  belongs_to :assigned_to, class_name: "User"

  scope :completed, -> { where.not(completed_at: nil) }
  scope :not_completed, -> { where(completed_at: nil) }

  # @return [TrueClass, FalseClass]
  def completed? = completed_at.present?
end
