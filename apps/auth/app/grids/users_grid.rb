class UsersGrid
  include Datagrid

  scope { User }

  column :id
  column(:name, html: true) { |record| link_to(record.display_name, record) }
  column :role
  column :created_at
end