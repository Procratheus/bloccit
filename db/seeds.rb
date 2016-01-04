require 'faker'

User.destroy_all
Topic.destroy_all
Post.destroy_all
Comment.destroy_all
Question.destroy_all
Answer.destroy_all

admin = User.new(
  role: 'admin',
  name: Faker::Name.name,
  email: 'admin@example.com',
  password: 'administrator'
)
admin.skip_confirmation!
admin.save!

moderator = User.new(
  role: 'moderator',
  name: Faker::Name.name,
  email: 'moderator@example.com',
  password: 'moderator'
)
moderator.skip_confirmation!
moderator.save!

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

200.times do
  topic = Topic.new(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )
  topic.save!
end

topics = Topic.all

5000.times do
  post = Post.new(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
  )
  post.save!
  post.update!(created_at: rand(10.mins .. 1.year).ago)
  post.update_rank
end

posts = Post.all

20000.times do
  comment = Comment.new(
    post: posts.sample,
    body: Faker::Lorem.paragraph
    user: users.sample
  )
  comment.save!
end

comments = Comment.all

50.times do
  question = Question.new(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
  question.save!
end

questions = Question.all

100.times do
  answer = Answer.new(
    question: questions.sample,
    body: Faker::Lorem.paragraph
  )
  answer.save!
end

answers = Answer.all

puts "Seeds finished"
puts "#{users.count} users created"
puts "#{topics.count} topics created"
puts "#{posts.count} posts created."
puts "#{comments.count} comments created."
puts "#{questions.count} questions created."
puts "#{answers.count} answer created."
