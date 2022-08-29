# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy do
  let_it_be(:user1) { create(:user) }
  let_it_be(:user2) { create(:user) }
  let_it_be(:post1) { create(:post, user: user1) }

  describe '#delete?' do
    context 'when current user is the owner of the post' do
      let(:policy) { described_class.new(post1, user: user1) }

      it 'must authorize deletion of post' do
        expect(policy.delete?).to be(true)
      end
    end

    context 'when current user is not the owner of the post' do
      let(:policy) { described_class.new(post1, user: user2) }

      it 'must not authorize deletion of post' do
        expect(policy.delete?).to be(false)
      end
    end
  end

  describe '#update?' do
    context 'when current user is the owner of the post' do
      let(:policy) { described_class.new(post1, user: user1) }

      it 'must authorize updation of post' do
        expect(policy.update?).to be(true)
      end
    end

    context 'when current user is not the owner of the post' do
      let(:policy) { described_class.new(post1, user: user2) }

      it 'must not authorize updation of post' do
        expect(policy.update?).to be(false)
      end
    end
  end
end
