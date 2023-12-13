require_relative '../base'

module Pages
  class ProductCardSection < BasePage
    #Constructor
    def initialize(browser, page, card_title, card_id=nil)
      @browser = browser
      @page = page
      @id = card_id || nil
      @card_title = card_title
    end

    #Locator methods (keep one liners!)
    private def product_card_base = @page.locator("//div[@class='tile'][div[contains(text(),\"#{@card_title}\")]][div[@class='tileImage']#{@id.nil? ? '' : "[img[@src=\"/images/#{@id.to_s}.png\"]]"}]")
    private def add_button = product_card_base.locator("//div[@class='tileAdd']")
    private def price = product_card_base.locator("//div[@class='tilePrice']")

    #Section methods
    def click_add(quantity)
      quantity.times do
        add_button.click
      end
    end

    def displayed_price
      price_string_to_f(price.inner_text)
    end

    def is_visible?
      product_card_base.visible?
    end
  end
end