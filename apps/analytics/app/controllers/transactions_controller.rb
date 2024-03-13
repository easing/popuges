class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    # Дата не та, но что делать :)
    @stats = @transactions
               .select("sum(credit) as credit, sum(debit) as debit, sum(debit - credit) as balance, date_trunc('hour', created_at) as date")
               .group("date")
               .order("date desc")
               .map(&:attributes)
  end

  def show
  end
end