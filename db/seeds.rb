require 'faker'

User.destroy_all
Post.destroy_all
Comment.destroy_all
Question.destroy_all
Answer.destroy_all

admin = User.new(
  role: 'admin',
  name: Faker::Name.name,
  email: 'admin@example.com',
  password: 'admin'
)
admin.skip_confirmation!
admin.save

moderator = User.new(
  role: 'moderator',
  name: Faker::Name.name,
  email: 'moderator@example.com',
  password: 'moderator'
)
moderator.skip_confirmation!
moderator.save

8.times do
  user = User.new(
    role: 'member',
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end

users = User.all

50.times do
  post = Post.new(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
  post.save
end

posts = Post.all

100.times do
  comment = Comment.new(
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
  comment.save
end

comments = Comment.all

50.times do
  question = Question.new(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
  question.save
end

questions = Question.all

100.times do
  answer = Answer.new(
    question: questions.sample,
    body: Faker::Lorem.paragraph
  )
  answer.save
end

answers = Answer.all

puts "Seeds finished"
puts "#{users.count} users created"
puts "#{posts.count} posts created."
puts "#{comments.count} comments created."
puts "#{questions.count} questions created."
puts "#{answers.count} answer created."
