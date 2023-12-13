require_relative '../models/product'

module APIHelper
  class RequestSender
    attr_accessor :context

    def initialize(context)
      @context = context
    end

    def all_published_products
      @context.get("#{ENV['BASE_API_URI']}/product/")
    end

    def find_username(username)
      @context.get("#{ENV['BASE_API_URI']}/customer/username=#{username}")
    end

    def delete_all_users
      @context.delete("#{ENV['BASE_API_URI']}/customer/")
    end

    def delete_customer(username)
      res = find_username(username)
      @context.delete("#{ENV['BASE_API_URI']}/customer/#{res.json['customerIf'].to_s}")
    end

    def add_customer(user_h)
      @context.post("#{ENV['BASE_API_URI']}/customer/",
                       headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
                       data: user_h.to_json,
                       )

    end
  end
end