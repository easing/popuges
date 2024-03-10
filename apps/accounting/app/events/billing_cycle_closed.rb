# frozen_string_literal: true

##
class BillingCycleClosed < Event
  def topic = "billing_cycles_workflow"
end