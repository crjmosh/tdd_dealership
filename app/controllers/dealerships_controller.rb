class DealershipsController < ApplicationController
	before_action :set_dealership, except: [:index, :new, :create]

  def index
  	@dealerships = Dealership.all
  end

  def show
  end

  def new
  	@dealership = Dealership.new
  end

  def create
  	@dealership = Dealership.new(dealership_params)
  	if @dealership.save
  		redirect_to @dealership, notice: 'Dealership created.'
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @dealership.update(dealership_params)
  		redirect_to dealership_path(@dealership), notice: 'Dealership updated.'
  	else
  		render :edit
  	end
  end

  def destroy
  	@dealership.destroy
  	redirect_to dealerships_path, notice: 'Dealership removed.'
  end

  private

  def dealership_params
  	params.require(:dealership).permit(:name, :location)
  end

  def set_dealership
  	@dealership = Dealership.find(params[:id])
  end
end
