# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  role       :string
#  public_id  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  provider   :string
#  uid        :string
#
class User < ::ApplicationRecord
  include UserConcern

  has_many :billing_cycles, dependent: :restrict_with_exception
  has_many :transactions, through: :billing_cycles

  has_one :current_billing_cycle,
          -> { where(current: true) },
          inverse_of: :user,
          class_name: "BillingCycle",
          dependent: :restrict_with_exception

  def balance
    current_billing_cycle&.transactions&.sum("debit - credit") || 0
  end
end
