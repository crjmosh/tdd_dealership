require 'rails_helper'

RSpec.describe Dealership, type: :model do
  describe 'associations' do
  	it { should have_many :cars }
  end

  describe 'validations' do
  	Dealership.create(name: 'Test', location: 'Utah')
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:location) }
  	# it { should validate_uniqueness_of(:name) }
  end

  describe 'instance methods' do
  	describe '#cars_count' do
  		it 'returns a message with the dealership name and number of cars' do
  			dealership = Dealership.create(name: 'Test Dealership', location: 'Utah')
  			car1 = Car.create(make: 'Acura', model: 'Integra',
  												year: 2001, miles: 100000, dealership_id: dealership.id )
  			car2 = Car.create(make: 'Honda', model: 'Accord',
  												year: 1981, miles: 150000, dealership_id: dealership.id)
  			expect(dealership.cars_count).to eq("Test Dealership - 2 cars")
  		end
  	end
  end

  describe 'class methods' do
  	describe '.by_name' do
  		it 'returns the dealerships ordered by name' do
  			d1 = Dealership.create(name: 'Test Dealership', location: 'Utah')
  			d2 = Dealership.create(name: 'Another Dealership', location: 'Utah')
  			d3 = Dealership.create(name: 'Other Dealership', location: 'Utah')
  			by_name = Dealership.all.by_name
  			expect(by_name[0].name).to eq(d2.name)
  			expect(by_name[1].name).to eq(d3.name)
  			expect(by_name[2].name).to eq(d1.name)
  		end
  	end
  end

end
