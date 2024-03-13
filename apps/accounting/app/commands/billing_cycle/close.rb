class BillingCycle::Close < ApplicationInteraction
  record :user

  run_in_transaction!

  def execute
    billing_cycle = user.current_billing_cycle
    return unless billing_cycle

    billing_cycle.update!(current: false)

    EDA.stream BillingCycle::Closed.new(billing_cycle.as_event_data)
  end
end