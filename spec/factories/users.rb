require 'faker'
require 'bcrypt'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email(domain: 'example') }
    password { "password" }
  end
end
