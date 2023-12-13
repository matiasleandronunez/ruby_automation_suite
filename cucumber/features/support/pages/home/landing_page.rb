require_relative '../base'

module Pages
  class LandingPage < BasePage
    private def checkout_button = @page.get_by_text('Checkout')
    private def create_user_button = @page.get_by_text('Create User')
    private def sign_in_user_button = @page.get_by_text('Sign In')

    #Section methods
    def go_to_checkout
      checkout_button.click
    end

    def go_to_create_user
      create_user_button.click
    end
  end
end
