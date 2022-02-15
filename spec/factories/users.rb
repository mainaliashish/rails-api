require 'faker'
require 'bcrypt'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email(domain: 'example') }
    password { BCrypt::Password.create('password') }
  end
end
