# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:user) }
  end
end
