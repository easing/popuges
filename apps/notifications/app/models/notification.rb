# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  subject    :string           default(""), not null
#  user_id    :bigint
#  public_id  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
##
class Notification < ApplicationRecord
  belongs_to :user, optional: true

  scope :ordered, -> { order(created_at: :desc) }

  default_scope { ordered }
end
