FactoryGirl.define do
  factory :bank_train_level, class: BankTrain::Level do
    sequence(:name) { |n| "level-#{n}" }
  end
end