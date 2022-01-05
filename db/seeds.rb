# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'seeding...'
User.create(email: 'john@gmail.com', password: 'password', username: 'johnboy', name: 'John')
User.create(email: 'jeff@jeff.com', password: 'password', username: 'jeffdoe', name: 'Jeff')
puts 'seeded'


def user_params(user)
  name = `#{Faker::Name.first_name} #{Faker::Name.last_name}`
  username = Faker::Internet.username(specifier: name)
  email = Faker::Internet.email(name: name)
  password = 'password'
  blood_type = Faker::BloodType.type
  education = Faker::Educator.campus

end 