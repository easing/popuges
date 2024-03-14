class DashboardController < ApplicationController

  def index
    transactions = Transaction.all

    # Дата не та, но что делать :)
    @company_stats = transactions
                       .select("sum(debit - credit) as balance, date_trunc('day', created_at) as date")
                       .order("date DESC")
                       .group("date")
                       .map(&:attributes)

    @stats_by_day = Transaction.stats_by_day

    @top_credited = transactions.where(transaction_type: "task_assigned")
                                .order(Arel.sql "date_trunc('day', created_at) desc")
                                .group("date_trunc('day', created_at)")
                                .maximum(:credit)

    @top_debited = transactions.where(transaction_type: "task_completed")
                               .order(Arel.sql "date_trunc('day', created_at) desc")
                               .group("date_trunc('day', created_at)")
                               .maximum(:debit)

    @daily_stats = {
      count: Transaction.where("created_at::date = CURRENT_DATE").group(:user_id).having("sum(credit - debit) > 0").count.size,
      sum: Transaction.where("created_at::date = CURRENT_DATE").sum("credit - debit"),
      debit: Transaction.where("created_at::date = CURRENT_DATE").sum("debit")
    }.with_indifferent_access
  end
end