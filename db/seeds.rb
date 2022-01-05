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
  path = Rails.root.join("app/assets/images/Seed Avatars", filename)
  File.open(path) do |io|
    user.avatar.attach(io: io, filename: filename)
  end
end

def set_user
  name = `#{Faker::Name.first_name} #{Faker::Name.last_name}`
  username = Faker::Internet.username(specifier: name)
  email = Faker::Internet.email(name: name)
  password = 'password'
  blood_type = Faker::BloodType.type
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

@user = []

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


  40.times do |i|
    @users << User.create!(set_user)
  end

  User.create(email: 'john@gmail.com', password: 'password', username: 'johnboy', name: 'John')

  # create posts
  user_posts = []
  120.times do |i|
    date = Faker::Date.between(from: 2.years.ago, to: Date.today)
    body = case i
            when 0..36 then Faker::GreekPhilosophers.quote
            when 37..72 then Faker::Quotes::Shakespeare.hamlet_quote
            when 73..108 then Faker::Quotes::Shakespeare.as_you_like_it_quote
            when 109..144 then Faker::Quotes::Shakespeare.king_richard_iii_quote
            else Faker::Quotes::Shakespeare.romeo_and_juliet_quote
            end

    user_posts << user_posts.create!(
      body: body,
      user_id: @users[rand(@users.length)],
      created_at: date,
      updated_at: date
    )
  end

end
puts 'seeded'