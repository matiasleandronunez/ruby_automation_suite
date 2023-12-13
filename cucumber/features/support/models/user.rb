require 'json'
# frozen_string_literal: true

class User
  attr_accessor :id, :name, :address, :email, :phone, :username, :role, :password

  def initialize(hash_attributes)
    self.id = hash_attributes['customerId'] || nil
    self.name = hash_attributes['name'] || nil
    self.address = hash_attributes['address'] || nil
    self.email = hash_attributes['email'] || nil
    self.phone = hash_attributes['phone'] || nil
    self.username = hash_attributes['username'] || nil
    self.role = hash_attributes['role'] || nil
    self.password = hash_attributes['password'] || nil
  end

  def to_h
    {'customerId' => id, 'name' => name, 'address' => address, 'email' => email, 'phone' => phone, 'username' => username, 'role' => role, 'password' => password}
  end
end