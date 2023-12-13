require_relative '../base'

module Pages
  class CreateUser < BasePage
    #Locator methods, only callable by PAGES to avoid calling directly in steps and keep encapsulation (one liners!)
    private def username_input = @page.locator(css="input[name=username]")
    private def password_input = @page.locator(css="input[name=password]")
    private def signup_button = @page.locator(css="div.createFormButton button")

    #Page methods
    def input_user(name='someone', password='qwerty12')
      username_input.fill(name)
      password_input.fill(password)
    end

    def click_sign_up_button
      signup_button.click
    end
  end
end