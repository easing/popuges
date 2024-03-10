# frozen_string_literal: true

#
class BillingCycleEndsHandler < ::Handler
  def call
    User.joins(:current_billing_cycle).find_each do |user|
      BillingCycle.transaction do
        CloseBillingCycle.run!(user: user)
        StartBillingCycle.run!(user: user)
      end
    end
  end
end
