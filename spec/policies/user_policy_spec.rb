require 'rails_helper'

RSpec.describe UserPolicy do
  let_it_be(:user1) { create(:user) }
  let_it_be(:user2) { create(:user) }

  describe '#delete?' do
    context 'when current user tries to delete itself' do
      let(:policy) { described_class.new(user1, user: user1) }

      it 'must authorize deletion of user' do
        expect(policy.delete?).to eq(true)
      end
    end

    context 'when current user tries to delete other user' do
      let(:policy) { described_class.new(user1, user: user2) }

      it 'must not authorize deletion of user' do
        expect(policy.delete?).to eq(false)
      end
    end
  end

  describe '#update?' do
    context 'when current user tries to update itself' do
      let(:policy) { described_class.new(user1, user: user1) }

      it 'must authorize updation of user' do
        expect(policy.update?).to eq(true)
      end
    end

    context 'when current user tries to update other user' do
      let(:policy) { described_class.new(user1, user: user2) }

      it 'must not authorize updation of user' do
        expect(policy.update?).to eq(false)
      end
    end
  end
end