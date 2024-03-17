##
class BillingCyclesController < ApplicationController
  load_and_authorize_resource

  def index
    @grid = BillingCyclesGrid.new { @billing_cycles }
  end

  def show

  end

  def close
    @billing_cycles.find_each do |cycle|
      BillingCycle::Close.run!(billing_cycle: cycle)
    end

    redirect_back fallback_location: root_path, notice: @billing_cycles.size
  end
end