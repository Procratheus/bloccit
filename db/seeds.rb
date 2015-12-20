require 'faker'

Post.destroy_all
Comment.destroy_all
Question.destroy_all
Answer.destroy_all

50.times do
  post = Post.new(
    title: Faker::Lorem::sentence,
    body: Faker::Lorem::paragraph
  )
  post.save
end

posts = Post.all

100.times do
  comment = Comment.new(
    post: posts.sample,
    body: Faker::Lorem::paragraph
  )
  comment.save
end

comments = Comment.all

50.times do
  question = Question.new(
    title: Faker::Lorem::sentence,
    body: Faker::Lorem::paragraph
  )
  question.save
end

questions = Question.all

100.times do
  answer = Answer.new(
    question: questions.sample,
    body: Faker::Lorem::paragraph
  )
  answer.save
end

answers = Answer.all

puts "#{posts.count} posts created."
puts "#{comments.count} comments created."
puts "#{questions.count} questions created."
puts "#{answers.count} answer created."
