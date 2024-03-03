class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @transactions = @transactions.reorder(created_at: :desc)
  end

  def show
  end
end