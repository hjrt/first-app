# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def answer_accepted_preview
		UserMailer.answer_accepted(User.first, Answer.first, Question.first)
    end

	def question_answered_preview
		UserMailer.question_answered(User.first, Answer.first, Question.first)
    end


end
