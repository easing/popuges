class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.reorder(created_at: :desc)
  end

  def show
    @notification = Notification.find(params[:id])
  end
end