class UsersController < ApplicationController
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
end
