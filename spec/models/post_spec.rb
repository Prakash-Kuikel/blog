# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end

  describe 'Comments counter cache' do
    let_it_be(:user) { create(:user) }
    let_it_be(:post) { create(:post, user: user) }
    let_it_be(:comment1) { create(:comment, post: post, user: user) }
    let_it_be(:initial_count) { post.comments.size }

    context 'when new comment is created' do
      let_it_be(:comment2) { create(:comment, post: post, user: user) }

      it 'must increase counter cache by 1' do
        expect(current_count).to eq(initial_count + 1)
      end
    end

    context 'when a comment is deleted' do
      it 'must reduce counter cache by 1' do
        described_class.first.comments.first.destroy!
        expect(current_count).to eq(initial_count - 1)
      end
    end

    def current_count
      Post.first.comments.size
    end
  end
end
