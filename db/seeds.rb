# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'seeding...'
User.create(email: 'john@john.com', password: 'password', username: 'johnboy', name: 'John')
User.create(email: 'jeff@jeff.com', password: 'password', username: 'jeffdoe', name: 'Jeff')
puts 'seeded'
