# frozen_string_literal: true

##
class Users::SessionsController < Devise::SessionsController
  before_action do
    prepend_view_path Rails.root.join("../../views/")
  end
end
