require 'faker'
require_relative '../models/user'

module CommonsHelper
  def self.random_user
    User.new({
               'name'=> Faker::Name.name,
               'address'=> Faker::Address.street_address,
               'email'=> Faker::Internet.email,
               'phone'=> Faker::PhoneNumber.phone_number_with_country_code,
               'username'=> Faker::Internet.username,
               'role' => 'user',
               'password' => 'qwerty12'
             })
  end
end