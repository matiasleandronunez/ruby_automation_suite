require 'json'
# frozen_string_literal: true

class Product
  attr_accessor :id, :name, :price, :description, :image

  def initialize(hash_attributes)
    self.id = hash_attributes['productId']
    self.name = hash_attributes['name']
    self.price = hash_attributes['price']
    self.description = hash_attributes['description']
    self.image = hash_attributes['image']
  end
end