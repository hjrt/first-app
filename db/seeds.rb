u1 = User.create({username: 'test1', email: 'example1@example.com', password: '123456', password_confirmation: '123456'})
u2 = User.create({username: 'test2', email: 'example2@example.com', password: '123456', password_confirmation: '123456'})
u3 = User.create({username: 'test3', email: 'example3@example.com', password: '123456', password_confirmation: '123456'})

q1 = Question.create({title: 'What are the best Ruby on Rails practices?', user: u1})

Answer.create({question: q1, content: 'Use translations', user: u1})
Answer.create({question: q1, content: 'Reusable scopes and relations', user: u2})
Answer.create({question: q1, content: 'Fat model, skinny controller', user: u2})
Answer.create({question: q1, content: 'Package your code into gems', user: u3})
