class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit]
  
  def new; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      flash[:danger] = "Please try again"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = "User not found"
    redirect_to root_path
  end
end
