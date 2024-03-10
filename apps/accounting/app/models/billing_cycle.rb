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

  def amount = transactions.sum(Arel.sql "debit - credit")
end
