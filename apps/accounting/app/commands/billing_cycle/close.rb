class BillingCycle::Close < ApplicationInteraction
  record :billing_cycle

  def execute
    return unless billing_cycle.current?
    return if billing_cycle.balance.negative?

    BillingCycle.transaction do
      billing_cycle.update!(current: false)
      BillingCycle.create!(user: billing_cycle.user, name: Date.today.to_s, current: true)
    end

    EDA.stream BillingCycle::Closed.new(billing_cycle.as_event_data)
  end
end