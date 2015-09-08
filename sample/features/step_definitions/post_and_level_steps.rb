Before {
  train_user = FactoryGirl.create :train_user

  # 岗位
  train_posts = FactoryGirl.create_list :bank_train_post, 3
  train_user.train_posts = train_posts

  # 级别
  train_level = FactoryGirl.create :bank_train_level, :name => 'level-1'
  train_user.train_level = train_level
  train_user.save

  # 业务类型
  business_categories = FactoryGirl.create_list :bank_train_business_category, 2
  train_posts[0].business_categories = business_categories

  # 业务操作
  business_operations = FactoryGirl.create_list :bank_train_business_operation, 10
  business_categories[0].business_operations = business_operations

  @train_user = User.last
}

假如(/^用户登录到系统$/) do
  expect(@train_user).to_not be_nil
end

当(/^用户尝试获取自己的岗位$/) do
  @train_posts = @train_user.train_posts
end

那么(/^用户看到自己的一个到多个岗位$/) do
  expect(@train_posts.count).to eq 3
end

当(/^用户尝试获取自己的级别$/) do
  @train_level = @train_user.train_level
end

那么(/^用户看到自己的级别$/) do
  expect(@train_level.name).to eq 'level-1'
end

假如(/^用户确认了自己的岗位$/) do
  expect(@train_user.train_posts.count).to eq 3
end

当(/^用户尝试获取自己能够操作的业务类型$/) do
  @business_categories = @train_user.train_business_categories
end

那么(/^用户看到自己能够操作的业务类型$/) do
  expect(@business_categories.count).to eq 2
end

假如(/^用户确认了自己的岗位和级别$/) do
  expect(@train_user.train_posts.count).to eq 3
  expect(@train_user.train_level).to_not be_nil
end

假如(/^用户指定一种业务类型$/) do
  @business_category = @train_user.train_business_categories.first
  expect(@business_category).to_not be_nil
end

当(/^用户尝试获取自己能够进行的业务操作$/) do
  @c_business_operations = @train_user.train_business_operations_by_category(@business_category)
end

那么(/^用户看到自己能够进行的业务操作$/) do
  expect(@c_business_operations.count).to eq 10
end

当(/^用户尝试获取自己能够进行的全部业务操作$/) do
  @all_business_operations = @train_user.train_business_operations
end

那么(/^用户看到自己能够进行的全部业务操作$/) do
  expect(@c_business_operations.count).to eq 10
end
