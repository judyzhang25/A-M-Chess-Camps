class SessionsController < ApplicationController
  include AppHelpers::Cart
  
  def new
  end
  
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      create_cart
      redirect_to home_path, notice: "Logged in!"
    else
      flash.now.alert = "Username and/or password is invalid"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    destroy_cart
    redirect_to home_path, notice: "Logged out!"
  end
  
  def see_cart
    @items = session[:cart]
    @total = calculate_total_cart_registration_cost
  end
  
  def add_item
    add_registration_to_cart(:camp_id, :student_id)
    camp = Camp.find(:camp_id)
    student = Student.find(:student_id)
    flash notice = "#{camp.name} for #{student.first_name} was added to your cart!"
  end
  
  def remove_item
    remove_registration_from_cart(:camp_id, :student_id)
    camp = Camp.find(:camp_id)
    student = Student.find(:student_id)
    flash notice = "#{camp.name} for #{student.first_name} was removed from your cart."
  end
  
  def clear
    clear_cart
  end
end