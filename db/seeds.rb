u1 = User.create({username: 'test1', email: 'example1@example.com', password: '123456', password_confirmation: '123456'})
u2 = User.create({username: 'test2', email: 'example2@example.com', password: '123456', password_confirmation: '123456'})
u3 = User.create({username: 'test3', email: 'example3@example.com', password: '123456', password_confirmation: '123456'})

q1 = Question.create({title: 'What are the best Ruby on Rails practices?', user: u1})

Answer.create({question: q1, content: 'Use translations', user: u1})
Answer.create({question: q1, content: 'Reusable scopes and relations', user: u2})
Answer.create({question: q1, content: 'Fat model, skinny controller', user: u2})
Answer.create({question: q1, content: 'Package your code into gems', user: u3})

q2 = Question.create({title: 'How to pronounce doggo?', user: u2})

Answer.create({question: q2, content: 'Barf', user: u1})
Answer.create({question: q2, content: 'BORK', user: u3})
Answer.create({question: q2, content: 'You are doing me a frighten', user: u3})

q3 = Question.create({title: 'Which is worse, ignorance or apathy?', user: u3})

Answer.create({question: q3, content: 'I do not know and I do not care', user: u1})