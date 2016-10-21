class Search

	def self.find_questions(keywords)
		questions = Question.order(created_at: :desc)
		questions.where("title like ? OR content like?", "%#{keywords}%", "%#{keywords}%") if keywords.present?
	end

	def self.find_answers(keywords)
		answers = Answer.order(created_at: :desc)
		answers.where("content like ?", "%#{keywords}%") if keywords.present?
	end

	def self.find_users(keywords)
		users = User.order(:username)
		users.where("username like ?", "%#{keywords}%") if keywords.present?
	end


end
