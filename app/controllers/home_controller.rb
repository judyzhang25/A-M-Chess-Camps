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
  
  def dashboard
  end
  
end