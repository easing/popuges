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

  before_validation do
    self.jira_id ||= begin
                       match = subject.match(/\[(.*)\]/)
                       if match
                         match[1]
                       else
                         ""
                       end
                     end

    self.subject = subject.gsub(/\[.*\]/, "").strip
  end

  scope :completed, -> { where.not(completed_at: nil) }
  scope :not_completed, -> { where(completed_at: nil) }

  scope :ordered, -> { order(created_at: :desc) }

  default_scope { ordered }

  after_initialize :set_public_id, if: :new_record?

  after_commit(on: :create) do
    EDA.stream Task::Created.new(as_event_data)
    EDA.stream Task::Created.new(as_event_data, version: 1) # TODO: убрать после миграции события
  end

  after_commit(on: :update) do
    EDA.stream Task::Updated.new(as_event_data)
    EDA.stream Task::Updated.new(as_event_data, version: 1) # TODO: убрать после миграции события
  end

  def completed? = completed_at.present?

  def as_event_data
    {
      public_id: public_id,
      assignee_id: assignee.public_id,
      completed_at: completed_at,
      subject: subject,
      jira_id: jira_id,
    }
  end
end
