class Badge < ApplicationRecord
	has_and_belongs_to_many :users

	# def to_s
	# 	name
	# end

	def image
		self.name.downcase.gsub(/[\s\!]/,'')
	end
	
end