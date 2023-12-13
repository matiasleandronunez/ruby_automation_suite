Given('I post an existing customer to the customer create endpoint') do
  @current_response = @api_helper.add_customer(@user.to_h)
end

Given('I post a new customer to the customer create endpoint') do
  step('I post an existing customer to the customer create endpoint') # <= Re-user the step the difference is in the data, which is instantiated in the before hook for each case
end

Given('I delete a customer to the customer delete endpoint') do
  @current_response = @api_helper.delete_customer(username= @user.username)
end

Then('I verify I get a conflict response from the API') do
  expect(@current_response.status).to eq(409), "Expected HTTP409, got #{@current_response.status}.\n#{@current_response.body}"
end

Then('I verify I get a no content response from the API') do
  expect(@current_response.status).to eq(204), "Expected HTTP204, got #{@current_response.status}.\n#{@current_response.body}"
end

Then('I verify I get a entity created response from the API') do
  expect(@current_response.status).to eq(201), "Expected HTTP201, got #{@current_response.status}.\n#{@current_response.body}"
end

Then('I verify I get the customer ID from the API response') do
  expect(@current_response.json['customerId']).to be_a_kind_of(Integer)
end
