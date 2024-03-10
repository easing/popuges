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
#
class User < ::ApplicationRecord
  include UserConcern

  has_many :transactions, dependent: :destroy
  has_many :tasks, inverse_of: :assignee, dependent: :destroy

  def balance
    transactions.sum(Arel.sql "debit - credit")
  end
end
