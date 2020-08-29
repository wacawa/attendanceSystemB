# coding: utf-8

User.create!(name: "養性光明",
             email: "sample@email.com",
             department: "社長",
             password: "password",
             password_confirmation: "password",
             admin: true,
            )
            
            
49.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  department = "エンジニア"
  password = "password"
  User.create!(name: name,
               email: email,
               department: department,
               password: password,
               password_confirmation: password,
              )
end