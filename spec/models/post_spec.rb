require 'rails_helper'

MIN_TITLE_LENGTH = 3
MAX_TITLE_LENGTH = 100
MIN_CONTENT_LENGTH = 10
MAX_CONTENT_LENGTH = 400

RSpec.describe Api::V1::Post, type: :model do
  context 'it should validate the post title' do
    it 'is not valid without post title' do
      post = build(:api_v1_post, title: nil)
      expect(post).to_not be_valid
    end

    it 'is valid with post title' do
      post = build(:api_v1_post, user_id: User.first.id)
      expect(post).to be_valid
    end

    it "is not valid with post title less than #{MIN_TITLE_LENGTH}" do
      title = 'a' * 2
      post_one = build(:api_v1_post, title: title)
      expect(post_one).to_not be_valid
    end

    it "is not valid with post title greater than #{MAX_TITLE_LENGTH}" do
      title = 'a' * 120
      post_two = build(:api_v1_post, title: title)
      expect(post_two).to_not be_valid
    end

    it 'should have a unique title' do
      title = "I am a sample title #{rand.to_s[2..9]} "
      create(:api_v1_post, title: title, user_id: User.first.id)
      expect { create(:api_v1_post, title: title) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'it should validate the post content' do
    it 'is not valid without post content' do
      post = build(:api_v1_post, content: nil)
      expect(post).to_not be_valid
    end

    it 'is valid with post content' do
      post = build(:api_v1_post, user_id: User.first.id)
      expect(post).to be_valid
    end

    it "is not valid with post content less than #{MIN_CONTENT_LENGTH}" do
      content = 'a' * 5
      post = build(:api_v1_post, content: content)
      expect(post).to_not be_valid
    end

    it "is not valid with post content greater than #{MAX_CONTENT_LENGTH}" do
      content = 'a' * 500
      post_one = build(:api_v1_post, content: content)
      expect(post_one).to_not be_valid
    end
  end

  context 'it should have a post creator' do
    it 'is not valid without post creator' do
      post = build(:api_v1_post, user_id: nil)
      expect(post).to_not be_valid
    end

  end
  
end
