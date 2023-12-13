require_relative '../models/product'

module APIHelper
  class RequestSender
    attr_accessor :context

    def initialize(context)
      @context = context
    end

    def all_published_products
      @context.get("#{ENV['base_api_uri']}/product/")
    end

    def find_username(username)
      @context.get("#{ENV['base_api_uri']}/customer/username=#{username}")
    end

    def delete_all_users
      @context.delete("#{ENV['base_api_uri']}/customer/")
    end

    def delete_customer(username)
      res = find_username(username)
      @context.delete("#{ENV['base_api_uri']}/customer/#{res.json['customerIf'].to_s}")
    end

    def add_customer(user_h)
      @context.post("#{ENV['base_api_uri']}/customer/",
                       headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
                       data: user_h.to_json,
                       )

    end
  end
end