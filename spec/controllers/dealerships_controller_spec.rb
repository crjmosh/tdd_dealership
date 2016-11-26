require 'rails_helper'

RSpec.describe DealershipsController, type: :controller do


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "sets the dealerships instance variable" do
      Dealership.destroy_all
      get :index
      expect(assigns(:dealerships)).to eq([])
    end
  end

  describe "GET #show" do
    before(:each) do
      @dealership = Dealership.create(name: 'Test', location: 'Utah')
    end

    it "returns http success" do
      get :show, id: @dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, id: @dealership.id
      expect(response).to render_template(:show)
    end

    it "sets the dealership instance variable" do
      get :show, id: @dealership.id
      expect(assigns(:dealership).name).to eq(@dealership.name)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "sets the new instance variable" do
      get :new
      expect(assigns(:dealership)).to_not eq(nil)
      expect(assigns(:dealership).id).to eq(nil)
    end
  end

  describe "POST #create" do
    before(:all) do
      @dealership_params = { dealership: { name: 'Fake', location: 'Utah' }}
    end

    describe "success" do
      it "sets the dealership instance variable" do
        post :create, @dealership_params
        expect(assigns(:dealership)).to_not eq(nil)
        expect(assigns(:dealership).name).to eq(@dealership_params[:dealership][:name])
      end

      it "creates a new dealership" do
        Dealership.destroy_all
        expect(Dealership.count).to eq(0)
        post :create, @dealership_params
        expect(Dealership.count).to eq(1)
        expect(Dealership.first.name).to eq(@dealership_params[:dealership][:name])
      end

      it "sets the flash message on success" do
        post :create, @dealership_params
        expect(flash[:notice]).to eq('Dealership created.')
      end
    end

    describe "failure" do
      it 'renders new on failure' do
        dealership2 = { dealership: { name: 'Imaginary Dealership' }}
        post :create, dealership2
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      @dealership = Dealership.create(name: 'Test', location: 'Utah')
    end

    it "returns http success" do
      get :edit, id: @dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, id: @dealership.id
      expect(response).to render_template(:edit)
    end

    it "sets the dealership instance variable" do
      get :edit, id: @dealership.id
      expect(assigns(:dealership).id).to eq(@dealership.id)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @dealership = Dealership.create(name: 'Test Dealership', location: 'Utah')
    end

    describe 'successes' do
      it 'sets the dealership instance variable' do
        put :update, { id: @dealership.id, dealership: {name: 'New Dealership' }}
        expect(assigns(:dealership).id).to eq(@dealership.id)
      end

      it 'updates the dealership' do
        put :update, { id: @dealership.id, dealership: {name: 'New Dealership' }}
        expect(@dealership.reload.name).to eq('New Dealership')
      end

      it 'sets flash message on success' do
        put :update, { id: @dealership.id, dealership: {name: 'New Dealership' }}
        expect(flash[:notice]).to eq('Dealership updated.')
      end

      it 'redirects to show on success' do
        put :update, { id: @dealership.id, dealership: {name: 'New Dealership' }}
        expect(response).to redirect_to(dealership_path(@dealership.id))
      end
    end

    describe 'failures' do
      it 'renders edit on fail' do
        # dealership2 = Dealership.create(name: 'Fake Dealership')
        put :update, { id: @dealership.id, dealership: { name: nil }}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      Dealership.destroy_all
      @dealership = Dealership.create(name: 'Test', location: 'Utah')
    end

    it 'sets the dealership instance variable' do
        delete :destroy, id: @dealership.id
        expect(assigns(:dealership)).to eq(@dealership)
    end

    it 'destroys the dealership' do
      expect(Dealership.count).to eq(1)
      delete :destroy, id: @dealership.id
      expect(Dealership.count).to eq(0)
    end

    it 'sets the flash message' do
      delete :destroy, id: @dealership.id
      expect(flash[:notice]).to eq('Dealership removed.')
    end

    it 'redirects to index path after destroy' do
      delete :destroy, id: @dealership.id
      expect(response).to redirect_to(dealerships_path)
    end
  end

end
