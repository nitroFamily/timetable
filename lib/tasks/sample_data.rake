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

    group = Group.all(limit: 6)
    50.times do
      group.each { |group| group.lessons.create!(name: "Тест",
                                                form: 1,
                                                number: 3,
                                                classroom: "531/2",
                                                day: 4,
                                                start_week: 1,
                                                end_week: 18) }
    end
  end

  task add_lessons: :environment do
    group = Group.first
    50.times do |i|
      group.lessons.create!(name: "test#{i}", 
                            form: "#{i%3 + 1}",
                            number: "#{i%5 + 1}",
                            classroom: "531/2",
                            day: "#{i%6+1}",
                            start_week: 1,
                            end_week: 18) 
    end
  end
end