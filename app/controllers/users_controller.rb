class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    # finding all the active owners and paginating that list (will_paginate)
    @users = User.all.alphabetical.paginate(page: params[:users]).per_page(15)
  end

  def new
    @user = User.new
  end
  
  def show
  end
  
  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully added #{@user.username} as a user."
      redirect_to users_url
    else
      render action: 'new'
    end
  end

  def update
    if user_params[:password].nil?
      if @user.update_attributes(user_params)
        flash[:notice] = "Successfully updated #{@user.username}."
        redirect_to user_url(@user)
      else
        render action: 'edit'
      end
    elsif @user.update_attributes(user_no_pass_params)
      flash[:notice] = "Successfully updated #{@user.username}."
      redirect_to user_url(@user)
    else
      render action: 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: "Successfully removed #{@user.username} from the PATS system."
    else
      render action: 'show'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:active, :username, :role, :password, :password_confirmation, :email, :phone)
    end
    
    def user_params
      params.require(:user).permit(:active, :username, :role, :email, :phone)
    end

end
