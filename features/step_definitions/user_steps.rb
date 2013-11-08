### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :name => "Testy McUserton", :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme" }
end

def find_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email])
end

def delete_user
  @user ||= User.find_by email: @visitor[:email]
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "Name", :with => @visitor[:name]
  fill_in "Email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^我没有登录$/ do
  visit '/users/sign_out'
end

Given /^我已经登录$/ do
  create_user
  sign_in
end

Given /^我是注册用户$/ do
  create_user
end

Given /^我不是注册用户/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^我用有效信息直接登录$/ do
  create_visitor
  sign_in
end

When /^我选择退出$/ do
  visit '/users/sign_out'
end

When /^我使用有效的用户数据注册$/ do
  create_visitor
  sign_up
end

When /^我使用无效Email地址注册$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^我注册时没有输入确定密码$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^我注册时没有输入密码$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^我注册时两次输入密码不同$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^我返回到主页$/ do
  visit '/'
end

When /^我用错误的Email登录$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^我用错误的密码登录$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^我更改我的帐户信息$/ do
  click_link "帐户信息"
  click_link "修改信息"
  fill_in "Name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^我查看用户列表$/ do
  visit '/'
end


### THEN ###
Then /^我应该已经登录$/ do
  page.should have_content "退出"
  page.should_not have_content "注册"
  page.should_not have_content "登录"
end

Then /^我应该没有登录$/ do
#  page.should have_content "退出"
  page.should have_content "登录"
#  page.should_not have_content "退出"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^我看到登录有效通知$/ do
  page.should have_content "Signed in successfully."
end

Then /^我看到登录成功通知$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^我看到Email无效的消息通知$/ do
  page.should have_content "Emailis invalid"
end

Then /^我看到密码空白的消息通知$/ do
  page.should have_content "Passwordcan't be blank"
end

Then /^我看到两次输入密码不匹配的消息通知$/ do
  page.should have_content "Passworddoesn't match confirmation"
end

Then /^我看到退出成功通知$$/ do
  page.should have_content "Signed out successfully."
end

Then /^我看到登录无效通知$/ do
  page.should have_content "Invalid email or password."
end

Then /^我看更改成功的消息通知$/ do
  page.should have_content "You updated your account successfully."
end

Then /^我应该看到我的名字$/ do
  create_user
  page.should have_content @user[:name]
end
