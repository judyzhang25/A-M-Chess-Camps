class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy, :instructors, :students]
  authorize_resource

  def index
    @active_camps = Camp.all.active.chronological.paginate(:page => params[:active_camps]).per_page(10)
    @inactive_camps = Camp.all.inactive.chronological.paginate(:page => params[:inactive_camps]).per_page(1)
    @camp1 = Curriculum.where(name: "Principles of Chess")
    @camp2 = Curriculum.where(name: "Endgame Principles")
    @camp3 = Curriculum.where(name: "Mastering Chess Tactics")
  end

  def show
    @instructors = @camp.instructors.alphabetical
    @families = @camp.students.map(&:family)
    @students = @camp.students.alphabetical
    @eligible_students = Student.all.active.alphabetical.where('rating IN (?)', (@camp.curriculum.min_rating..@camp.curriculum.max_rating))
  end

  def edit
  end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to camp_path(@camp), notice: "#{@camp.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    @camp.update(camp_params)
    if @camp.save
      redirect_to camp_path(@camp), notice: "#{@camp.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @camp.destroy
    redirect_to camps_url, notice: "#{@camp.name} was removed from the system."
  end
  
  def instructors
    @instructors = Instructor.for_camp(@camp).alphabetical
  end
  
  def students
    @students = @camp.students.alphabetical
  end

  private
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active)
    end
end