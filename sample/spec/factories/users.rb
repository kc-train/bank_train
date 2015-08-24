FactoryGirl.define do
  factory :user do
    name "tom"
    email { "#{name}@example.com" }
    password "1234"
  end

  factory :train_user, class: User do
    name "jerry"
    email { "#{name}@example.com" }
    password "1234"
  end 
end