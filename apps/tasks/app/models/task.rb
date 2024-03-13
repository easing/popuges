# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  subject      :string           not null
#  assignee_id  :bigint
#  completed_at :datetime
#  public_id    :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :assignee, class_name: "User"

  scope :completed, -> { where.not(completed_at: nil) }
  scope :not_completed, -> { where(completed_at: nil) }

  scope :ordered, -> { order(created_at: :desc) }

  default_scope { ordered }

  after_initialize :set_public_id, if: :new_record?

  after_commit(on: :create) { EDA.stream Task::Created.new(as_event_data) }
  after_commit(on: :update) { EDA.stream Task::Updated.new(as_event_data) }

  def completed? = completed_at.present?

  def as_event_data
    {
      public_id: public_id,
      assignee_id: assignee.public_id,
      completed_at: completed_at,
      subject: subject
    }
  end
end
