# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!,
                :init_shared_views,
                :set_current_ability,
                unless: :devise_controller?

  attr_reader :current_ability
  helper_method :current_ability

  private

  def init_shared_views
    prepend_view_path Rails.root.join("../../views/")
  end

  def set_current_ability
    @current_ability = Ability.new(current_user)
  end
end
