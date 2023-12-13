require_relative '../base'

module Pages
  class CheckoutPage < BasePage
    #Locator methods, only callable by PAGES to avoid calling directly in steps and keep encapsulation (one liners!)
    private def quantity_span(product_title) = @page.locator("//div[text()='#{product_title}']/following-sibling::div/span[contains(text(),'Quantity')]")
    private def product_individual_price(product_title) = @page.locator("//div[text()='#{product_title}']/ancestor::div[@class='productItem']//div[@class='columnRight']")
    private def subtotal_amount = @page.locator("//div[@class='totalDetails']//span[text()='subtotal']/following-sibling::span")
    private def shipping_amount = @page.locator("//div[@class='totalDetails']//span[text()='shipping']/following-sibling::span")
    private def taxes_amount = @page.locator("//div[@class='totalDetails']//span[text()='taxes']/following-sibling::span")
    private def total_amount = @page.locator("//div[@class='totalFinal']//span[text()='Total']/following-sibling::span")

    #Page methods
    def product_quantity_in_cart(product_title)
      price_string_to_f(quantity_span(product_title).inner_text)
    end

    def product_price_in_cart(product_title)
      price_string_to_f(product_individual_price(product_title).inner_text)
    end

    def cart_subtotal
      price_string_to_f(subtotal_amount.inner_text)
    end

    def cart_shipping
      price_string_to_f(shipping_amount.inner_text)
    end

    def cart_taxes
      price_string_to_f(taxes_amount.inner_text)
    end

    def cart_total
      price_string_to_f(total_amount.inner_text)
    end
  end
end