class UsersController < ApplicationController
  load_and_authorize_resource except: [:create_popug]

  def create_popug
    pass = SecureRandom.hex
    user = User.new(
      name: "Popug #{SecureRandom.hex(2)}",
      email: "#{SecureRandom.hex}@easing.ru",
      role: User.roles[:popug],
      password: pass,
      password_confirmation: pass
    )

    authorize! :create, user

    user.save!

    redirect_back fallback_location: user_path(user)
  end

  def employ_popugs
    User::EmployNewPopugs.run!
    redirect_back fallback_location: users_path
  end

  def fire_popugs
    User::FireRandomPopugs.run!
    redirect_back fallback_location: users_path
  end

  def index
    @grid = UsersGrid.new { @users.order(created_at: :desc) }
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