namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = Group.create!(name: "admin",
                         email: "admin@admin.admin",
                         password: "adminadmin",
                         password_confirmation: "adminadmin",
                         admin: true)
    Group.create!(name: "test",
                 email: "test@test.test",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "testGroup-#{n+1}@gb.ru"
      password  = "password"
      Group.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end