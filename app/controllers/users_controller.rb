class UsersController < ApplicationController
  before_action :signed_in_user, only:[:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Welcome to the Sample App!"
      sign_in(@user)
  	  redirect_to root_path
  	else
  	  render action:"new"
  	end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_user
      redirect_to signin_path, notice:"please sign in" unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user=(@user)
    end
end
