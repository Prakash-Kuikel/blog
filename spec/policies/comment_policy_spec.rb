# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy do
  let_it_be(:user1) { create(:user) }
  let_it_be(:user2) { create(:user) }
  let_it_be(:user3) { create(:user) }
  let_it_be(:post) { create(:post, user: user1) }
  let_it_be(:comment) { create(:comment, post: post, user: user2) }

  describe '#delete?' do
    context 'when current user is the owner of the comment' do
      let(:policy) { described_class.new(comment, user: user2) }

      it 'must authorize deletion of comment' do
        expect(policy.delete?).to be(true)
      end
    end

    context 'when current user is the owner of the post under which the comment exists' do
      let(:policy) { described_class.new(comment, user: user1) }

      it 'must authorize deletion of comment' do
        expect(policy.delete?).to be(true)
      end
    end

    context 'when current user is neither the owner of the post nor of the comment' do
      let(:policy) { described_class.new(comment, user: user3) }

      it 'must not authorize deletion of comment' do
        expect(policy.delete?).to be(false)
      end
    end
  end

  describe '#update?' do
    context 'when current user is the owner of the comment' do
      let(:policy) { described_class.new(comment, user: user2) }

      it 'must authorize updation of comment' do
        expect(policy.update?).to be(true)
      end
    end

    context 'when current user is not the owner of the comment' do
      let(:policy) { described_class.new(comment, user: user1) }

      it 'must not authorize updation of comment' do
        expect(policy.update?).to be(false)
      end
    end
  end
end
