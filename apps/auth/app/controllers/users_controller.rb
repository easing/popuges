class UsersController < ApplicationController
  load_and_authorize_resource
  def index
  end

  def show
  end

  def change_role
    @user
  end

  private
  def role_params
    params.require(:user).permit(:role)
  end
end