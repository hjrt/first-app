class Question < ApplicationRecord
	has_many :answers
	belongs_to :user
	validates :title, presence: true

end
