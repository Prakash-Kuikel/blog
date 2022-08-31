# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments) }
  end

  describe 'Posts counter cache' do
    let_it_be(:user) { create(:user) }
    let_it_be(:post1) { create(:post, user: user) }
    let_it_be(:initial_count) { user.posts.size }

    context 'when new post is created' do
      let_it_be(:post2) { create(:post, user: user) }

      it 'must increase counter cache by 1' do
        expect(current_count).to eq(initial_count + 1)
      end
    end

    context 'when a post is deleted' do
      it 'must reduce counter cache by 1' do
        described_class.first.posts.first.destroy!
        expect(current_count).to eq(initial_count - 1)
      end
    end

    def current_count
      User.first.posts.size
    end
  end
end
