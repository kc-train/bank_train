FactoryGirl.define do
  factory :bank_train_business_category, class: BankTrain::BusinessCategory do
    sequence(:name) { |n| "business-category-#{n}" }
  end
end