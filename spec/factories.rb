FactoryGirl.define do
  factory :user do
    name                  "Mathieu Gilbert"
    email                 "mathieu.gilbert@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
  
  factory :micropost do
    content     "FOO BAR"
    association :user
  end
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

