require 'cucumber'
require 'playwright'
require_relative 'helpers/request_sender'

#Defines and loads into the Cucumber "World" the browser and api request context as instance variables
module ExecutionContext
  def base_uri
    @base_uri ||= ENV['BASE_URI']
  end
end

World(ExecutionContext)

#One time Setup
def self.before_all
  Playwright.create(playwright_cli_executable_path: ENV['PLAYWRIGHT_CLI_EXECUTABLE_PATH']).playwright do |playwright|
    playwright.chromium.launch(headless: true) do |browser|
      helper = APIHelper::RequestSender.new(browser.new_context.request)
      helper.delete_all_users.status == 204
    end
  end
end

raise Exception("Failed to run Setup before test") unless before_all

at_exit do
end