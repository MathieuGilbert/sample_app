FactoryGirl.define do
  factory :user do
    name                  "Mathieu Gilbert"
    email                 "mathieu.gilbert@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end