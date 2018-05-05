Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search
  get 'home/dash', to: 'home#dash', as: :dash
  root 'home#index'

  # Routes for main resources
  resources :camps
  resources :instructors
  resources :locations
  resources :curriculums
  resources :users
  resources :sessions
  resources :families
  resources :students
  resources :camp_instructors, :only => [:new, :create, :destroy]
  
  # Other custom routes
  get 'camps/:id/instructors', to: 'camps#instructors', as: :camp_instructors_for
  post 'camps/:id/instructors', to: 'camp_instructors#create', as: :add_instructors
  delete 'camps/:id/instructors/:instructor_id', to: 'camp_instructors#destroy', as: :camp_instructor_for
  
  # Routes for managing registrations
  # get 'registrations/new', to: 'registrations#new', as: :new_registration
  # post 'registrations', to: 'registrations#add_item', as: :add_item #'registrations/:id/students/:student_id'
  # delete 'registrations', to: 'registrations#destroy', as: :registration
  
  # #cart
  # get 'cart', to: 'registrations#see_cart', as: :items
  # delete 'cart', to: "registrations#remove_item", as: :item
  
  get 'camps/:id/students', to: 'camps#students', as: :camp_students
  post 'camps/:id/students', to: 'registrations#add_item', as: :registrations
  delete 'camps/:id/students/:student_id', to: 'registrations#destroy', as: :remove_item
  
  # Routs for managing users and sessions
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
end
