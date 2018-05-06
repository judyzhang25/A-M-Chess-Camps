class RegistrationsController < ApplicationController
  include AppHelpers::Cart
  def new
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to home_path, notice: "Your order is complete!"
    else
      render action: 'new'
    end
  end

  def destroy
    # @registration.destroy
    camp_id = params[:id]
    student_id = params[:student_id]
    @registration = Registration.where(camp_id: camp_id, student_id: student_id)
    student = Student.find(student_id)
    camp = Camp.find(camp_id)
    unless @registration.nil?
        @registration.destroy_all
        flash[:notice] = "#{student.proper_name} was successfully removed from #{camp.name}."
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
    remove_registration_from_cart(camp_id, student_id)
    camp = Camp.find(camp_id)
    student = Student.find(student_id)
    redirect_to items_path
    flash[:notice] = "#{camp.name} for #{student.first_name} was removed from your cart."
  end
  
  def checkout
    number = params[:number].delete(' ')
    expiry = params[:expiry].split('/')
    month = expiry[0].to_i
    year = expiry[1].to_i
    unless session[:cart].nil? || session[:cart].empty?
      reg_ids = session[:cart].map{|ci| ci['ids']}
    end
    reg_ids.each do |reg|
      student_id = reg[1]
      camp_id = reg[0]
      r = Registration.new(camp_id: camp_id, student_id: student_id, credit_card_number: number, expiration_month: month, expiration_year: year)
      unless r.save && r.pay
        redirect_to items_path, notice: "Your order did not go through."
        return
      end
    end
    clear_cart
    redirect_to home_path, notice: "Your order is complete!"
  end
    
   

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:student_id, :camp_id, :credit_card_number, :expiration_year, :expiration_month)
    end
end