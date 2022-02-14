FactoryBot.define do
  factory :api_v1_post, class: 'Api::V1::Post' do
    sequence(:title) { |n| "Deserunt reprehenderit commodo amet aute #{n}" }
    content { 'In non fugiat ut nostrud proident velit sit quis veniam aliquip officia sunt velit.' }
    user_id { 8 }
  end
end
