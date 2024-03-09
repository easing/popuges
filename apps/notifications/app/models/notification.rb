##
class Notification < ApplicationRecord
  belongs_to :user, optional: true

  scope :ordered, -> { order(created_at: :desc) }

  default_scope { ordered }
end
