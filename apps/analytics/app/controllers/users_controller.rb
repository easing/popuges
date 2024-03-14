class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @transactions = Transaction.all
    today_transactions = @transactions.where("date_trunc('day', created_at) = ?", Date.today)

    @top_credited = today_transactions.order(credit: :desc).limit(5)
    @top_debited = today_transactions.where("date_trunc('day', created_at) = ?", Date.today).order(debit: :desc).limit(5)

    @users = @users.joins(:transactions).distinct

    # Дата не та, но что делать :)
    @stats = Transaction
               .all
               .select("sum(credit) as credit, sum(debit) as debit, sum(credit - debit) as balance, date_trunc('hour', created_at) as date")
               .group("date")
               .order("date desc")
               .map(&:attributes)
  end

  def show
  end
end