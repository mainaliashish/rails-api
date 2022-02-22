require 'faker'
FactoryBot.define do
  factory :api_v1_post, class: 'Api::V1::Post' do
    title { Faker::Lorem.sentence(word_count: 5) }
    content { Faker::Lorem.paragraph_by_chars(number: 256) }
    user_id { 8 }
  end
end
