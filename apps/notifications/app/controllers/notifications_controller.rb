class NotificationsController < ApplicationController
  load_and_authorize_resource

  def index
    @grid = NotificationsGrid.new { @notifications }
  end

  def show
  end
end