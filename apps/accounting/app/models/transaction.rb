# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  billing_cycle_id :bigint           not null
#  description      :string           default(""), not null
#  debit            :integer          default(0), not null
#  credit           :integer          default(0), not null
#  public_id        :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :billing_cycle
  has_one :user, through: :billing_cycle

  scope :ordered, -> { order(created_at: :desc) }

  default_scope { ordered }

  after_initialize :set_public_id, if: :new_record?

  validates :debit, :credit, numericality: { greater_than_or_equal_to: 0 }

  def as_event_data
    {
      public_id: public_id,
      user_id: billing_cycle.user.public_id,
      description: description,
      credit: credit,
      debit: debit
    }
  end
end
