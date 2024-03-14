# frozen_string_literal: true

##
class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!,
                :init_shared_views,
                unless: :devise_controller?

  helper_method :current_ability

  private

  def init_shared_views
    prepend_view_path Rails.root.join("../../views/")
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
