FactoryGirl.define do
  factory :bank_train_business_operation, class: BankTrain::BusinessOperation do
    sequence(:name) { |n| "business-operation-#{n}" }
  end
end