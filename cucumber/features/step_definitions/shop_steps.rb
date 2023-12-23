Given('I go to the storefront') do
  @landing_page = Pages::LandingPage.new(@browser, @page)
  @landing_page.navigate(execution_context.base_uri)
end

When(/^I click on add ([0-9]+) times for ([A-Z|a-z|0-9\s]+)$/) do |quantity, item_name|
  @product_card = Pages::ProductCardSection.new(@browser, @page, item_name)
  @product_card.click_add(quantity.to_i)
end

When('I proceed to checkout') do
  @landing_page.go_to_checkout
  @checkout_page = Pages::CheckoutPage.new(@browser, @page)
end

Then(/^I verify ([A-Z|a-z|0-9\s]+) was added to the cart ([0-9]+) times$/) do |item_name, quantity|
  expect(@checkout_page.product_quantity_in_cart(item_name)).to eq quantity.to_i
end

Then('I verify subtotal equals {float} by {int}') do |float, int|
  expect(@checkout_page.cart_subtotal).to eq (float * int)
end

Then('I verify taxes amount ${float} by {int}') do |float, int|
  expect(@checkout_page.cart_taxes).to eq (float * int)
end

Then('I verify all items are displayed') do
  response = @api_helper.all_published_products
  expect(response.status).to eq 200

  response.json.map { |product| Product.new(product) }.each do |product|
    expect(Pages::ProductCardSection.new(@browser, @page, product.name, product.id).is_visible?).to be true
  end
end
