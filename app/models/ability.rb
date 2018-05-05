class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
      
    elsif user.role? :instructor
      #read any info in system related to curriculums, locations, or camps
      can :read, Curriculum
      can :read, Camp
      can :read, Location
      
      #can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end
      
      #can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end
      
      #can see list of all students in their camps
      can :index, Student
      
      #can see details of students attending their camps
      can :show, Student do |this_student|
        instructor = Instructor.find_by(user_id: user.id)
        students = (instructor.camps.map { |c| c.students.map(&:id) }).flatten
        students.include? this_student.id
      end
      
      #can see details of families of students attending their camps
      can :show, Family do |this_family|
        instructor = Instructor.find_by(user_id: user.id)
        families = (instructor.camps.map { |c| c.students.map(&:family) }).flatten
        families.include? this_family
      end
      
      can :instructors, Camp
      can :students, Camp
      
    elsif user.role? :parent
      #can read their own profile
      can :show, User do |u|
        u.id == user.id
      end
      
      #can update their own profile
      can :update, User do |u|
        u.id == user.id
      end
      
      #can read all information on curriculums and camps
      can :read, Curriculum
      can :read, Camp
      can :show, Location
      
      #can manage all of their students
      can :manage, Student do |s|
        family = Family.find_by(user_id: user.id)
        s.family_id == family.id
      end
      
      #can see own family page
      can :show, Family do |f|
        f == Family.find_by(user_id: user.id)
      end

      #can create new registrations for students in their family, but may not edit
      #or remove those registrations once payment is made.
      can :create, Registration
      
      #cannot view any information about students and families they are not
      #associated with, save for a list of registrered students on the camp
      #details page.
      
      can :instructors, Camp
      can :students, Camp
      
    else
      #can read camp and curriculums but cannot see registration list only open slots
      can :read, Camp
      can :read, Curriculum
      
      #can create new user/family accounts
      can :create, User
      can :create, Family
      
      can :instructors, Camp
      can :students, Camp
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
