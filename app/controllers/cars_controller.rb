class CarsController < ApplicationController
  before_action :set_dealership
  before_action :set_car, except: [:index, :new, :create]

  def index
  	@cars = @dealership.cars.all
  end

  def show
  end

  def new
  	@car = @dealership.cars.new
  end

  def create
  	@car = @dealership.cars.new(car_params)
  	if @car.save
  		redirect_to dealership_car_path(@dealership, @car), notice: 'Car added.'
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @car.update(car_params)
  		redirect_to dealership_car_path(@dealership, @car), notice: 'Car updated.'
  	else
  		render :edit
  	end
  end

  def destroy
  	@car.destroy
  	redirect_to dealership_cars_path(@dealership), notice: 'Car removed.'
  end

  private

  def car_params
  	params.require(:car).permit(:make, :model, :year, :miles)
  end

  def set_dealership
  	@dealership = Dealership.find(params[:dealership_id])
  end

  def set_car
  	@car = @dealership.cars.find(params[:id])
  end
end
