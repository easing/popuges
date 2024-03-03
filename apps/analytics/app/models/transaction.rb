class Transaction < ApplicationRecord
  belongs_to :user

  after_commit :stream_balance_change, on: :create

  validates :debit, :credit, numericality: { greater_than_or_equal_to: 0 }

  private

  def stream_balance_change
    UserBalanceChanged.new(as_json).stream
  end
end
