class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @grid = UsersGrid.new { @users }
  end

  def show
  end
end