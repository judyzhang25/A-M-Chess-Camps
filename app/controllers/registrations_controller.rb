class RegistrationsController < ApplicationController
  include AppHelpers::Cart
  def new
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to registration_path(@registration), notice: "You have registered #{@registration.student.first_name} for #{@registration.camp.name}!"
    else
      render action: 'new'
    end
  end

  def destroy
    # @registration.destroy
    camp_id = params[:id]
    student_id = params[:student_id]
    @registration = Registration.where(camp_id: camp_id, student_id: student_id)
    unless @registration.nil?
        @registration.destroy
        flash[:notice] = "Successfully removed this registration"
    end
  end
  
  def see_cart
    @items = session[:cart]
    @total = calculate_total_cart_registration_cost
  end
  
  def add_item
    camp_id = params[:registration][:camp_id]
    student_id = params[:registration][:student_id]
    r = Registration.new(registration_params)
    if r.valid?
        add_registration_to_cart(camp_id, student_id)
        camp = Camp.find(camp_id)
        student = Student.find(student_id)
        redirect_to camp_path(camp)
        flash[:notice] = "#{camp.name} for #{student.first_name} was added to your cart!"
    end
  end
  
  def remove_item
    camp_id = params[:id]
    student_id = params[:student_id]
    remove_registration_from_cart(:camp_id, :student_id)
    camp = Camp.find(:camp_id)
    student = Student.find(:student_id)
    flash notice = "#{camp.name} for #{student.first_name} was removed from your cart."
  end
  
  def clear
    clear_cart
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:student_id, :camp_id, :credit_card_number, :expiration_year, :expiration_month)
    end
end