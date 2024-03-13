class Users::SessionsController < Devise::SessionsController
  layout "application"

  before_action do
    prepend_view_path Rails.root.join("../../views/")
  end
end
