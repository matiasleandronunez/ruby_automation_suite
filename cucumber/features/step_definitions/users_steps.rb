When('I go to the user creation screen') do
  @landing_page.go_to_create_user
end

When('I sign up a new user') do
  @user_create_page = Pages::CreateUser.new(@browser, @page)
  @user_create_page.input_user(name='someone')
  @user_create_page.click_sign_up_button
end

Then('I verify the new user account was created') do
  response = @api_helper.find_username('someone')
  expect(response.status).to eq 200
end