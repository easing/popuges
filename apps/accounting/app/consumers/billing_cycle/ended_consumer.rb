# frozen_string_literal: true

#
class BillingCycle::EndedConsumer < EDA::Handler
  version 1 do
    User.joins(:current_billing_cycle).find_each do |user|
      BillingCycle.transaction do
        BillingCycle::Close.run!(user: user)
        BillingCycle::Start.run!(user: user)
      end
    end
  end
end
