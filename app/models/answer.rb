class Answer < ApplicationRecord
	belongs_to :question
	belongs_to :user
	has_many :likes
	validates :content, presence: true
	#acts_as_votable

	# def self.by_accepted
 #  		self.order(accepted: :desc)
 #  	end

	
end
