class HomeController < ApplicationController
  
  def index
    def home_bool
      true
    end
  end

  def about
    def home_bool
      false
    end
  end

  def contact
    def home_bool
      false
    end
  end

  def privacy
    def home_bool
      false
    end
  end
  
  def dash
    def home_bool
      false
    end
    #admin
    Groupdate.time_zone = false
    @graph1 = Camp.joins(:registrations).joins(:curriculum).group(:name).count
    @max = Family.joins(:registrations).group(:family_name).size.max_by{|k,v| v}[1]
    @min = Family.joins(:registrations).group(:family_name).size.min_by{|k,v| v}[1]
    @max_fams = Family.joins(:registrations).group(:family_name).size.select{|k,v| v==@max}
    @min_fams = Family.joins(:registrations).group(:family_name).size.select{|k,v| v==@min}.first(13).to_h
    @graph2 = Camp.joins(:location).joins(:registrations).group(:name).count
    @graph3 = Camp.joins(:registrations).joins(:instructors).group(:first_name).count
    @graph4 = Camp.joins(:registrations).group_by_week(:start_date).count.sort_by{|x| x[1]}
    @revenue = Camp.joins(:registrations).map{|r| r.cost}.sum
    @upcoming_registrations = Camp.joins(:registrations).upcoming.size
    @past_registrations = Camp.joins(:registrations).past.size
  
    #family
    @family = current_role
    @instructor = current_role
    if current_user.role?(:parent)
      @students = current_role.students
      @all_camps = current_role.registrations.upcoming.chronological
      @my_camps = current_role.registrations.upcoming.chronological.limit(4)
    else
      @all_camps = current_role.camps.upcoming
      @my_camps = current_role.camps.upcoming.limit(5)
    end
  end
end