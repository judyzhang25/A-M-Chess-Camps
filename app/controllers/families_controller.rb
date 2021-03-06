class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @families = Family.all.alphabetical.paginate(:page => params[:families]).per_page(12)
  end

  def show
    @students = @family.students
    @registrations = @family.registrations
  end

  def edit
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    @user = User.new(user_params)
    @user.role = "parent"
    if !@user.save
      @family.valid?
      render action: 'new'
    else
      @family.user_id = @user.id
      if @family.save
        if session[:user_id].nil?
          redirect_to home_path, notice: "#{@family.family_name} was added to the system."
          return
        end
        redirect_to family_path(@family), notice: "#{@family.family_name} was added to the system."
      else
        render action: 'new'
      end
    end
  end

  def update
    @family.update(family_params)
    if !family_params[:password].nil?
      @user = User.find(@family.user_id)
      @user.update(user_params)
      @user.save
    end
    if @family.save
      redirect_to family_path(@family), notice: "The #{@family.family_name} family was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @family.destroy
    redirect_to families_url, notice: "The #{@family.family_name} family was removed from the system."
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:username, :password, :password_confirmation, :phone, :email, :family_name, :parent_first_name, :active)
    end
    
    def user_params
      params.require(:family).permit(:username, :password, :password_confirmation, :phone, :email, :active)
    end
end