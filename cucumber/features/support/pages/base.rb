module Pages
  class BasePage
    attr_accessor :browser
    attr_accessor :page

    def initialize(browser, page=nil)
      @browser = browser
      @page ||= page
    end

    def navigate(url)
      page.goto(url)
    end

    #Private cross-Pages utility methods
    private def price_string_to_f(price_s)
      price_s.tr("^0-9\.,", '').to_f
    end
  end
end