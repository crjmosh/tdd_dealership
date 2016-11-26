class Car < ApplicationRecord
	belongs_to :dealership

	validates_presence_of :make, :model, :year

	def info
		"#{year} #{make} #{model}"
	end

	def self.by_make
		order(:make)
	end
end
