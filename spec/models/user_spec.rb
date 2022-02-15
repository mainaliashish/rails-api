require 'rails_helper'

RSpec.describe User, type: :model do
  context 'it should validate the user email address' do
    it 'is not valid without email address' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid  
    end

    it 'is not valid without invalid email format' do
      user = build(:user, email: 'ashishmail.com')
      # binding.break
      expect(user).to_not be_valid
    end

    it 'is not valid if email already exists' do
      number = rand.to_s[1..6]
      email = "ashish#{number}@yahoo.com"
      # binding.break
      create(:user, email: email)
      expect { create(:user, email: email) }.to raise_error(ActiveRecord::RecordInvalid)  
    end
  end
  
end