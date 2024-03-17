class BillingCyclesGrid < ApplicationGrid
  scope { BillingCycle }

  column :id
  column :name, html: true do |resource|
    link_to resource.name, resource
  end

  column :user do |bc|
    bc.user.display_name
  end

  column :balance
  column :current?
  column :created_at
end