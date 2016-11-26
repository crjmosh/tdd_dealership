class Dealership < ApplicationRecord
	has_many :cars

	validates_presence_of :name, :location, null: false
	# validates_uniqueness_of :name

	def cars_count
		"#{name} - #{cars.count} cars"
	end

	def self.by_name
		order(:name)
	end

end
