# frozen_string_literal: true

require 'activerecord-import'
require 'faker'

USERS_NUMBER = 3
POSTS_NUMBER = 7
SCORES_NUMBER = 20
IP_NUMBER = 3

# time_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

# Create users
USERS_NUMBER.times do |i|
  User.create(login: Faker::Internet.username + i.to_s)
end

ips = (1..IP_NUMBER).map { Faker::Internet.ip_v4_address }

# Create Posts
posts = []
POSTS_NUMBER.times do
  posts << {
    title: Faker::Lorem.word,
    body: Faker::Lorem.paragraph(sentence_count: 3),
    ip: ips.sample,
    user_id: rand(1..USERS_NUMBER)
  }
end
Post.import posts, validate: false, batch_size: POSTS_NUMBER / 4

# Create Scores
SCORES_NUMBER.times do
  score = Score.create(level: rand(1..5), post_id: rand(1..POSTS_NUMBER))
  Score::Creator.new(post_id: score.post_id, level: score.level).post_update!(score)
end

# time_end = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# puts time_end - time_start
