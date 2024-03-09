# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  name       :string           default("")
# , not null
#  role       :string           default(NULL), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ::ApplicationRecord
  include UserConcern

  has_many :transactions

  def last_wage_transaction

  end
end
