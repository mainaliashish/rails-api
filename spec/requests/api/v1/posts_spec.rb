require 'rails_helper'
require 'faker'

RSpec.describe 'Api::V1::Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    sign_in user
  end

  def create_post(post)
    post '/api/v1/posts', params: { api_v1_post: post }
  end

  context 'GET #index' do
    it 'should get the posts' do
      get '/api/v1/posts'
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST #create' do
    it 'should create a post' do
      create_post(attributes_for(:api_v1_post, user_id: user.id))
      expect(response).to have_http_status(:created)
    end

    it 'should not create a post without title' do
      create_post(attributes_for(:api_v1_post, title: nil, user_id: user.id))
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not create a post without content' do
      create_post(attributes_for(:api_v1_post, content: nil, user_id: user.id))
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not create a post without title and description and user' do
      create_post(attributes_for(:api_v1_post, title: nil, content: nil, user_id: nil))
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'POST #show' do
    it 'should show a post based on post id' do
      post = Api::V1::Post.first
      get "/api/v1/posts/#{post.id}"
      expect { JSON.parse(response.body) }.not_to raise_error
    end

    it 'should raise exception if no post exists' do
      expect { get '/api/v1/post/10000' }.to raise_error(ActionController::RoutingError)
    end
  end

  context 'POST #destroy' do
    it 'should destroy a post associated with user' do
      post = create(:api_v1_post, user_id: user.id)
      delete "/api/v1/posts/#{post.id}"
      # binding.break
      expect(response).to have_http_status(204)
    end
  end
end
