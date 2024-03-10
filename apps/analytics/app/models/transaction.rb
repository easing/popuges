# == Schema Information
#
# Table name: transactions
#
#  id          :bigint           not null, primary key
#  description :string           default(""), not null
#  user_id     :bigint           not null
#  debit       :integer          default(0), not null
#  credit      :integer          default(0), not null
#  public_id   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :user
end
