class Search < ApplicationRecord

	attr_accessor :search

	def questions
		@questions = find_questions
	end

	def answers
		@answers =  find_answers
	end

	def users
		@users = find_users
	end

	private

	def find_questions
		questions = Question.order(created_at: :desc)
		questions = questions.where("title like ? OR content like?", "%#{keywords}%", "%#{keywords}%") if keywords.present?
		questions
	end

	def find_answers
		answers = Answer.order(created_at: :desc)
		answers = answers.where("content like ?", "%#{keywords}%") if keywords.present?
		answers
	end

	def find_users
		users = User.order(:username)
		users = users.where("username like ?", "%#{keywords}%") if keywords.present?
		users
	end


end
