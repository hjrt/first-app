class UserMailer < ApplicationMailer

  def question_answered(user, answer, question)
  	@user = user
  	@answer = answer
  	@question = question
  	mail(to: @user.email, subject: 'Your question has received new answer')
  end

  def answer_accepted(user, answer, question)
  	@user = user
  	@answer = answer
  	@question = question
  	mail(to: @user.email, subject: 'Your answer has been accepted')
  end

end
