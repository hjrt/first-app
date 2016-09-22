class Badge < ApplicationRecord
	has_and_belongs_to_many :users

	def to_s
		name
	end

	def superstar_alpaca
		badge1 = Badge.new(name: 'Superstar Alpaca')
		badge.save
	end

	def regular_alpaca
		badge2 = Badge.new(name: 'Regular Alpaca')
		badge.save
	end

	def disappointing_alpaca
		badge3 = Badge.new(name: 'Disappointing Alpaca')
		badge.save
	end
end