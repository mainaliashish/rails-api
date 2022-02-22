require 'rails_helper'

MAX_EMAIL_LENGTH = 105
MIN_PASSWORD_LENGTH = 6
MAX_PASSWORD_LENGTH = 50
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

    it "must have a valid email length of #{MAX_EMAIL_LENGTH}" do
      prefix = 'abc' * 106
      email = "#{prefix}@gmail.com"
      user = build(:user, email: email)
      expect(user).to_not be_valid
    end
  end

  context 'should validate the user password' do
    it 'is not valid without password' do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end

    it "should have minimum password length of #{MIN_PASSWORD_LENGTH}" do
      password = 'abc'
      user = build(:user, password: password)
      expect(user).to_not be_valid
    end

    it "should have maximum password length of #{MAX_PASSWORD_LENGTH}" do
      password = 'a' * 51
      user = build(:user, password: password)
      expect(user).to_not be_valid
    end
  end

  it 'is valid with a valid email address and password' do
    user = build(:user)
    expect(user).to be_valid
  end
end
