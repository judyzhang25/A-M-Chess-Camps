class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @active_carts = Cart.all.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_carts = Cart.all.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    # For sidebar card
    @upcoming_camps_at_cart = @cart.camps.upcoming.chronological
  end

  def edit
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to cart_path(@cart), notice: "#{@cart.name} cart was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @cart.update(cart_params)
      redirect_to cart_path(@cart), notice: "#{@cart.name} cart was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @cart.destroy
    redirect_to carts_url, notice: "#{@cart.name} cart was removed from the system."
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.require(:cart).permit(:name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :active)
    end
end