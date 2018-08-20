# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(firstName:  "Example",
	         lastName: "User",
             email: "example@railstutorial.org",
             phone: "4134133",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  firstName  = Faker::Name.first_name
  lastName = Faker::Name.last_name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  phone = "41341344"
  User.create!(firstName:  firstName,
  			   lastName: lastName,
               email: email,
               phone: phone,
               password:              password,
               password_confirmation: password)
end