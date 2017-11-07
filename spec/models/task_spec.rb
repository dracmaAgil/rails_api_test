require 'rails_helper'

RSpec.describe Task, type: :model do

  context 'attributes' do
    it { is_expected.to respond_to :description }
    it { is_expected.to respond_to :website }
    it { is_expected.to respond_to :header }
    it { is_expected.to respond_to :status }
    it { is_expected.to respond_to :expiration_date }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:website) }
  end

end
