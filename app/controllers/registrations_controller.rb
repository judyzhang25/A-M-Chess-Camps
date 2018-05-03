class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:destroy]
  authorize_resource
  
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
    @registration.destroy
    redirect_to registrations_url, notice: "#{@registration.name} was removed."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:student_id, :camp_id, :credit_card_number, :expiration_year, :expiration_month)
    end
end