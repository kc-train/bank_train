假如(/^用户登录到系统$/) do
  @train_user = FactoryGirl.create :train_user
end

当(/^用户尝试获取自己的岗位$/) do
  train_posts = FactoryGirl.create_list :bank_train_post, 3
  @train_user.train_posts = train_posts
  @train_user.reload
  @train_posts = @train_user.train_posts
end

那么(/^用户看到自己的一个到多个岗位$/) do
  expect(@train_posts.count).to eq 3
end

当(/^用户尝试获取自己的级别$/) do
  train_level = FactoryGirl.create :bank_train_level
  @train_user.train_level = train_level
  @train_user.reload
  @train_level = @train_user.train_level
end

那么(/^用户看到自己的级别$/) do
  expect(@train_level).to_not be_nil
end

假如(/^用户确认了自己的岗位$/) do
  pending # express the regexp above with the code you wish you had
end

当(/^用户尝试获取自己能够操作的业务类型$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^用户看到自己能够操作的业务类型$/) do
  pending # express the regexp above with the code you wish you had
end

假如(/^用户确认了自己的岗位和级别$/) do
  pending # express the regexp above with the code you wish you had
end

假如(/^用户指定一种业务类型$/) do
  pending # express the regexp above with the code you wish you had
end

当(/^用户尝试获取自己能够进行的业务操作$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^用户卡看到自己能够进行的业务操作$/) do
  pending # express the regexp above with the code you wish you had
end
