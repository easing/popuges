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

  def self.create_or_update_from_event(event)
    user = User.find_or_create_by!(public_id: event.data["user_id"])
    attributes_from_event = event.data.slice("public_id", "debit", "credit", "transaction_type", "description")

    Transaction
      .create_with(**attributes_from_event, user: user)
      .create_or_find_by!(public_id: event.data["public_id"])
  end

  def self.stats_for_today
    res = connection.execute <<~SQL
      WITH
      today as (select * from transactions where created_at::date = CURRENT_DATE),
        failed_users as (
          select user_id
          from today group by user_id having sum(credit - debit) > 0
        )
           
      select sum(credit - debit) from today           
    SQL

    res.first&.with_indifferent_access
  end

  def self.stats_by_day
    res = connection.execute <<~SQL
      with days as (select * from generate_series(timestamp '2024-03-08', CURRENT_TIMESTAMP, '1 day'::interval) day),
     transactions_stats as (select created_at::date    as day,
                                   count(*),
                                   sum(debit)          as debit,
                                   sum(credit)         as credit,
                                   sum(credit - debit) as balance
                            from transactions
                            group by day
                            order by day desc)
        ,
     users_daily_balances as (select created_at::date as day,
                                     user_id, 
                                     sum(credit - debit) as profit
                              from transactions
                              group by user_id, day),
     users_stats as (select day,
                            sum(profit)             as failed_users_profit,
                            count(distinct user_id) as failed_users_count
                     from users_daily_balances
                     where profit > 0
                     group by day
                     order by day desc),
     top_transactions as (select t.created_at::date as day,
                                 max(t.debit)       as max_debit
                          from transactions t
                          where t.transaction_type = 'task_completed'
                          group by day
                          order by day desc)

select days.day::date,
       users_stats.failed_users_count,
       users_stats.failed_users_profit,
       transactions_stats.balance,
       credit,
       debit,
       COALESCE(max_debit, 0) as max_debit
from days
         left join users_stats on users_stats.day = days.day
         left join transactions_stats on transactions_stats.day = days.day
         left join top_transactions on top_transactions.day = days.day
order by day desc
    SQL

    res.map(&:with_indifferent_access)
  end
end
