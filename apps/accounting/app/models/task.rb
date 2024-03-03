# == Schema Information
#
# Table name: tasks
#
#  id             :uuid             not null, primary key
#  subject        :string           not null
#  assigned_to_id :uuid
#  completed_at   :datetime
#  assign_price   :integer
#  complete_price :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :assigned_to, class_name: "User"
end
