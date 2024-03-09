# == Schema Information
#
# Table name: transactions
#
#  id          :uuid             not null, primary key
#  user_id     :uuid             not null
#  description :string           default(""), not null
#  debit       :integer          default(0), not null
#  credit      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :user

  scope :ordered, -> { order(created_at: :desc) }

  default_scope { ordered }

  after_initialize :set_public_id, if: :new_record?

  validates :debit, :credit, numericality: { greater_than_or_equal_to: 0 }
end
