require 'rails_helper'
require 'faker'
RSpec.describe 'Api::V1::Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    sign_in user
  end

  context 'GET /index' do
    it 'should get the posts' do
      get '/api/v1/posts'
      expect(response).to have_http_status(:ok)
    end
  end

  context 'CREATE post' do
    it 'should create a post' do
      post = {
        title: Faker::Lorem.sentence(word_count: 5),
        content: Faker::Lorem.paragraph_by_chars(number: 256),
        user_id: user.id
      }
      post '/api/v1/posts', params: { api_v1_post: post }
      # binding.break
      expect(response).to have_http_status(:created)
    end
    it 'should not create a post without title' do
      post = {
        title: nil,
        content: Faker::Lorem.paragraph_by_chars(number: 256),
        user_id: user.id
      }
      post '/api/v1/posts', params: { api_v1_post: post }
      # binding.break
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'should not create a post without title' do
      post = {
        title: Faker::Lorem.sentence(word_count: 5),
        content: nil,
        user_id: user.id
      }
      post '/api/v1/posts', params: { api_v1_post: post }
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'should not create a post without title and description and user' do
      post = {
        title: nil,
        content: nil,
        user_id: nil
      }
      post '/api/v1/posts', params: { api_v1_post: post }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
