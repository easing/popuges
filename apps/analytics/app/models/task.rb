# Задача
class Task < ApplicationRecord
  belongs_to :assignee, class_name: "User"

  scope :completed, -> { where.not(completed_at: nil) }
  scope :not_completed, -> { where(completed_at: nil) }

  def self.create_or_update_from_event(data)
    assignee = User.create_or_update_from_event("public_id" => data["assignee_id"])

    params = {
      **data.except("assignee_id", "public_id").slice(*column_names),
      "assignee" => assignee
    }

    record = create_with(params).create_or_find_by!(public_id: data["public_id"])
    record.update!(params)

    record
  end
end
