class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :currect_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroy"
    redirect_to users_url
  end

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
    @user = User.find(params[:id])
    if @user.update_attribute(params[:user])
      flash[:success] = "Profile update"
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
      unless signed_in?
        store_location
        redirect_to signin_url, notice:"please sign in" unless signed_in?
      end
    end

    def currect_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
