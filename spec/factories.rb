FactoryGirl.define do
  factory :group do
    sequence(:name)  { |n| "group #{n}" }
    sequence(:email) { |n| "group_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :lesson do
    name "Тест"
		form 1
		number 3
		classroom "531/2"
		day 4
		start_week 1
		end_week 18
    group
  end
end