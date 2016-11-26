require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'associations' do
  	it { should belong_to :dealership }
  end

  describe 'validations' do
  	it { should validate_presence_of(:make) }
  	it { should validate_presence_of(:model) }
  	it { should validate_presence_of(:year) }
  end

  describe 'instance methods' do
  	describe '#info' do
  		it 'returns the year, make, and model of a car' do
  			dealership = Dealership.create(name: 'Test Dealership', location: 'Utah')
  			car = Car.create(make: 'Acura', model: 'Integra',
  												year: 2001, dealership_id: dealership.id )
  			expect(car.info).to eq("2001 Acura Integra")
  		end
  	end
  end

  describe 'class methods' do
  	describe '.by_make' do
  		it 'returns the cars ordered by make' do
  			dealership = Dealership.create(name: 'Test Dealership', location: 'Utah')
  			c1 = Car.create(make: 'Honda', model: 'Accord',
  												year: 1981, dealership_id: dealership.id )
  			c2 = Car.create(make: 'Acura', model: 'Integra',
  												year: 2001, dealership_id: dealership.id )
  			c3 = Car.create(make: 'Ford', model: 'F150',
  												year: 2009, dealership_id: dealership.id )
  			by_make = Car.all.by_make
  			expect(by_make[0].make).to eq(c2.make)
  			expect(by_make[1].make).to eq(c3.make)
  			expect(by_make[2].make).to eq(c1.make)
  		end
  	end
  end
end
