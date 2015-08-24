FactoryGirl.define do
  factory :bank_train_post, class: BankTrain::Post do
    sequence(:name) { |n| "post-#{n}" }
  end
end