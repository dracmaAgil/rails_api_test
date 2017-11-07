require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build :user }
  subject { user }

  context 'attributes' do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :password }
  end

  context 'associations' do
    it { is_expected.to have_many(:tasks) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  context 'user with invalid and valid email ' do
    
    it 'email with invalid format is invalid' do
      user1 = User.new(name: 'alejandro', email: 'alex', password_digest: '12345')
      user1.valid?
      expect(user1.errors[:email]).to include('write a valid email format')
    end

    it 'email with valid format' do
      user.valid?
      expect(user).to be_valid
    end

  end

  context 'user with many taks' do

    def creating_tasks(user)
      task =  build :task, user: user
      task.save
    end

    it 'user have many taks' do
      user1 = create :user
      3.times{ creating_tasks(user1) } 
      expect(user1.tasks.count).to be 3
    end
  end

end
