class Answer < ApplicationRecord
	belongs_to :question
	belongs_to :user
	has_many :likes
	validates :content, presence: true
	scope :has_users_like_scope, -> (current_user) {likes.where("user_id = ?", current_user)}
	#acts_as_votable

	# def self.by_accepted
 #  		self.order(accepted: :desc)
 #  	end

	def has_users_like(user)
		self.likes.where({user: user}).any?
	end
end
