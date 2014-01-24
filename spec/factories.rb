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
end