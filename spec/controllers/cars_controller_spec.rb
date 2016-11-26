require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  before(:all) do
    @dealership = Dealership.create(name: 'Test Dealership', location: 'Utah')
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, dealership_id: @dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index, dealership_id: @dealership.id
      expect(response).to render_template(:index)
    end

    it "sets the cars instance variable" do
      get :index, dealership_id: @dealership.id
      expect(assigns(:cars)).to eq([])
    end
  end

  describe "GET #show" do
    before(:each) do
      @car = @dealership.cars.create(make: 'Acura', model: 'Integra',
                                     year: 2001, miles: 99000)
    end

    it "returns http success" do
      get :show, dealership_id: @dealership.id, id: @car.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, dealership_id: @dealership.id, id: @car.id
      expect(response).to render_template(:show)
    end

    it "sets the car instance variable" do
      get :show, dealership_id: @dealership.id, id: @car.id
      expect(assigns(:car).model).to eq(@car.model)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, dealership_id: @dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new, dealership_id: @dealership.id
      expect(response).to render_template(:new)
    end

    it "sets the new instance variable" do
      get :new, dealership_id: @dealership.id
      expect(assigns(:car)).to_not eq(nil)
      expect(assigns(:car).id).to eq(nil)
    end
  end

  describe "POST #create" do
    before(:all) do
      @car_params = { car: { make: 'Acura', model: 'Integra',
                             year: 2001, miles: 99000,
                             dealership_id: @dealership.id }}
    end

    describe "success" do
      it "sets the car instance variable" do
        post :create, @car_params.merge(dealership_id: @dealership.id)
        expect(assigns(:car)).to_not eq(nil)
        expect(assigns(:car).model).to eq(@car_params[:car][:model])
      end

      it "creates a new car" do
        expect(@dealership.cars.count).to eq(0)
        post :create, @car_params.merge(dealership_id: @dealership.id)
        expect(@dealership.cars.count).to eq(1)
        expect(@dealership.cars.first.model).to eq(@car_params[:car][:model])
      end

      it "sets the flash message on success" do
        post :create, @car_params.merge(dealership_id: @dealership.id)
        expect(flash[:notice]).to eq('Car added.')
      end
    end

    describe "failure" do
      it 'renders new on failure' do
        car2 = { car: { make: 'Imaginary' }}
        post :create, car2.merge(dealership_id: @dealership.id)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      @car = @dealership.cars.create(make: 'Acura', model: 'Integra',
                                     year: 2001, miles: 99000)
    end

    it "returns http success" do
      get :edit, dealership_id: @dealership.id, id: @car.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, dealership_id: @dealership.id, id: @car.id
      expect(response).to render_template(:edit)
    end

    it "sets the car instance variable" do
      get :edit, dealership_id: @dealership.id, id: @car.id
      expect(assigns(:car).id).to eq(@car.id)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @car = @dealership.cars.create(make: 'Acura', model: 'Integra',
                                     year: 2001, miles: 99000)
    end

    describe 'successes' do
      it 'sets the car instance variable' do
        put :update, { dealership_id: @dealership.id, id: @car.id, 
                       car: { model: 'RSX' }}
        expect(assigns(:car).id).to eq(@car.id)
      end

      it 'updates the car' do
        put :update, { dealership_id: @dealership.id, id: @car.id, 
                       car: { model: 'RSX' }}
        expect(@car.reload.model).to eq('RSX')
      end

      it 'sets flash message on success' do
        put :update, { dealership_id: @dealership.id, id: @car.id, 
                       car: { model: 'RSX' }}
        expect(flash[:notice]).to eq('Car updated.')
      end

      it 'redirects to show on success' do
        put :update, { dealership_id: @dealership.id, id: @car.id, 
                       car: { model: 'RSX' }}
        expect(response).to redirect_to(dealership_car_path(@dealership.id, @car.id))
      end
    end

    describe 'failures' do
      it 'renders edit on fail' do
        # dealership2 = Dealership.create(name: 'Fake Dealership')
        put :update, { dealership_id: @dealership.id, id: @car.id, 
                       car: { model: nil }}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
     @car = @dealership.cars.create(make: 'Acura', model: 'Integra',
                                     year: 2001, miles: 99000)
    end

    it 'sets the car instance variable' do
        delete :destroy, dealership_id: @dealership.id, id: @car.id
        expect(assigns(:car)).to eq(@car)
    end

    it 'destroys the car' do
      expect(@dealership.cars.count).to eq(1)
      delete :destroy, dealership_id: @dealership.id, id: @car.id
      expect(@dealership.cars.count).to eq(0)
    end

    it 'sets the flash message' do
      delete :destroy, dealership_id: @dealership.id, id: @car.id
      expect(flash[:notice]).to eq('Car removed.')
    end

    it 'redirects to index path after destroy' do
      delete :destroy, dealership_id: @dealership.id, id: @car.id
      expect(response).to redirect_to(dealership_cars_path(@dealership.id))
    end
  end

end
