require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username).is_at_least(4) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    # it { should validate_presence_of(:email) }
    # it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('email@example').for(:email) }
  end

  describe 'before_validation' do
    let(:user) { create(:user, email: 'Email@example.com') }

    it 'downcases the email' do
      expect(user.email).to eq('email@example.com')
    end
  end
end