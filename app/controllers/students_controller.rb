class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @students = Student.all.alphabetical.paginate(:page => params[:students]).per_page(10)
  end

  def show
    @upcoming_camps = @student.camps.upcoming.chronological
    @past_camps = @student.camps.past.chronological
  end

  def edit
    @family = current_role
  end

  def new
    @student = Student.new
    @family = current_role
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to student_path(@student), notice: "#{@student.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    @student.update(student_params)
    if @student.save
      redirect_to student_path(@student), notice: "#{@student.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: "#{@student.name} was removed from the system."
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end
end