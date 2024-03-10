class StartBillingCycle < ApplicationInteraction
  record :user
  string :name, default: -> { Time.zone.today.to_s }

  def execute
    return if user.reload.current_billing_cycle.present?

    BillingCycle.create!(user: user, name: name, current: true)
  end
end