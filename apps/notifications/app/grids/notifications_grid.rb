class NotificationsGrid < ApplicationGrid
  scope { Notification }

  column :id
  column :user, html: true do |record|
    link_to(record.user.display_name, record) if record.user
  end
  column :subject
  column :created_at
end