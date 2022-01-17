# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'seeding...'

def set_avatar!(user, name)
  filename = "#{name}.jpg"
  path = Rails.root.join("app/assets/images/seed_avatars", filename)
  File.open(path) do |io|
    user.avatar.attach(io: io, filename: filename)
  end
end

def set_user(name)
  name = name
  username = Faker::Internet.username(specifier: name)
  email = Faker::Internet.email(name: name)
  password = 'password'
  blood_type = Faker::Blood.type
  education = Faker::University.name

  {
    name: name,
    username: username,
    email: email,
    password: password,
    blood_type: blood_type,
    education: education
  }
end 

@users_arr = []

ActiveRecord::Base.transaction do
  Friendship.destroy_all
  FriendRequest.destroy_all
  Like.destroy_all
  Comment.destroy_all
  UserPost.destroy_all
  User.destroy_all

  ActiveRecord::Base.connection.reset_pk_sequence!('likes')
  ActiveRecord::Base.connection.reset_pk_sequence!('user_posts')
  ActiveRecord::Base.connection.reset_pk_sequence!('users')
  ActiveRecord::Base.connection.reset_pk_sequence!('friendships')
  ActiveRecord::Base.connection.reset_pk_sequence!('friend_requests')
  ActiveRecord::Base.connection.reset_pk_sequence!('comments')

  puts 'step 1 - creating users'
  24.times do
    name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
    @users_arr << User.create!(set_user(name))
  end

  test_user = User.create!(email: 'test@test.com', password: 'password', username: 'testuser', name: 'test', blood_type: 'A', education: 'University of California, Berkeley')

  @users_arr << test_user
  puts 'step 1 done'
  puts 'step 2 - creating posts'

  # create posts
  user_posts = []

  120.times do |i|
    date = Faker::Date.between(from: 2.years.ago, to: Date.today)
    body = case i
            when 0..36 then Faker::GreekPhilosophers.quote
            when 37..72 then Faker::Quotes::Shakespeare.hamlet_quote
            when 73..108 then Faker::Quotes::Shakespeare.as_you_like_it_quote
            when 109..120 then Faker::Quotes::Shakespeare.king_richard_iii_quote
            else Faker::Quotes::Shakespeare.romeo_and_juliet_quote
            end

    user_posts << UserPost.create!(
      message: body,
      user_id: @users_arr[rand(@users_arr.length)].id,
      created_at: date,
      updated_at: date
    )
  end

  puts 'step 2 done'

  puts 'step 3 - creating comments'
  comments = []
  user_posts.each do |post|
    rand(5).times do
      user = @users_arr[rand(@users_arr.length)]
      date = Faker::Date.between(from: post.created_at, to: Date.today)
      body = Faker::Quote.jack_handey
      comments << Comment.create!(user_post_id: post.id,
                                  user_id: user.id,
                                  message: body,
                                  created_at: date,
                                  updated_at: date)
    end
  end
  puts 'step 3 done'
  puts 'step 4 - creating likes'
  @users_arr.length.times do |i|
    rand(user_posts.length / 7).times { Like.create!(user_post_id: user_posts[rand(user_posts.length)].id, user_id: @users_arr[i].id) }
  end
  puts 'step 4 done'
  puts 'step 5 - creating friendships'
  @users_arr.length.times do |i|
    user_indices = ((i + 1)...@users_arr.length).to_a.shuffle
    (user_indices.length / 3).times do
      Friendship.create!(user_id: @users_arr[i].id, friend_id: @users_arr[(user_indices.pop)].id)
    end
  end
  puts 'step 5 done'
end

# puts 'last step - setting avatar'
# @users_arr.each_with_index do |user, index|
#   set_avatar!(user, index)
# end
# puts 'avatars set'
puts 'seeded'