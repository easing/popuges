class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @grid = TransactionsGrid.new { @transactions }
  end

  def show
  end
end