require 'playwright'
require_relative 'helpers/commons_helper'

Before do |scenario|
  #Initialize the browser
  #Playwright.connect_to_playwright_server(ENV['PLAYWRIGHT_SERVER_URL']) do |browser|
  #  @browser = browser
  #end

  # If API test, would not use a page nor need to launch browser in rendering mode. This would also
  # be the case if running in console environment, such as docker without gui
  is_an_api_test = scenario.tags.map(&:name).include?("@api_feature")

  playwright = Playwright.create(playwright_cli_executable_path: ENV['PLAYWRIGHT_CLI_EXECUTABLE_PATH']).playwright

  if is_an_api_test
    @browser = playwright.chromium.launch(headless: true, args: ['--disable-audio'])
  else
    @browser = playwright.chromium.launch(headless: ENV['HOST_HAS_GUI'].upcase == "FALSE" || false, args: ['--disable-audio'])
    @page = @browser.new_page
  end

  #Instantiate API helper regardless, as it might be also used for UI tests
  @api_helper = APIHelper::RequestSender.new(@browser.new_context.request)
end

Before("@delete_a_customer or @add_already_existing_customer") do |scenario|
  @user = CommonsHelper::random_user
  @current_response = @api_helper.add_customer(@user.to_h)
  skip_this_scenario(message="#{scenario.name}: Failed to create user in Before Hook") unless @current_response.status == 201
end

Before("@create_new_customer") do |scenario|
  @user = CommonsHelper::random_user
end

After do |scenario|
  @browser.close if @browser
end