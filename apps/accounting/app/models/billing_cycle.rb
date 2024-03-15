# == Schema Information
#
# Table name: billing_cycles
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  user_id    :bigint           not null
#  current    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BillingCycle < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :restrict_with_exception

  scope :current, -> { where(current: true) }
  scope :ordered, -> { order(created_at: :desc) }

  def balance = transactions.sum(Arel.sql("debit - credit"))

  def as_event_data
    {
      user_id: user.public_id,
      name: name,
      amount: balance
    }
  end
end
