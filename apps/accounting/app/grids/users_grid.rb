class UsersGrid < ApplicationGrid
  scope { User }

  column :id
  column :name
  column :balance
end