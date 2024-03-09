# == Schema Information
#
# Table name: tasks
#
#  id             :uuid             not null, primary key
#  subject        :string           not null
#  assignee_id :uuid
#  completed_at   :datetime
#  assign_price   :integer
#  complete_price :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :assignee, class_name: "User"

  def priced? = complete_price.present? || assign_price.present?

  def self.create_or_update_from_event(data)
    assignee = User.create_or_update_from_event("public_id" => data["assignee_id"])

    params = {
      "subject" => "",
      **data.slice(*column_names).except("assignee_id", "public_id"),
      "assignee" => assignee
    }

    record = create_with(params).create_or_find_by!(public_id: data["public_id"])
    record.update!(params)

    record
  end
end
