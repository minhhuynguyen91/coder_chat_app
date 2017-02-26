# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: 'admin', email: 'admin@example.com', password: 'asdf')
User.create!(username: 'a', email: 'a@example.com', password: 'asdf')
User.create!(username: 'b', email: 'b@example.com', password: 'asdf')
User.create!(username: 'c', email: 'c@example.com', password: 'asdf')

20.tmes do 
  Message.create!(
    :subject => Faker::Book.title,
    :content => Faker::ChuckNorris.fact
    :sender_id => 1
    :recipient_id => Faker::Number.between(2, 4)    
  )
end
