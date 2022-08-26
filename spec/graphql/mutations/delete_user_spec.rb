# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::Delete do
  context 'when user exists' do
    let(:user) { create(:user) }

    it 'must destroy user and return the same' do
      response, errors = formatted_response(query(user.id), key: :deleteUser)

      expect(errors).to be_nil
      expect(response[:deleteUser]).to be_truthy
    end
  end

  context 'when user does not exist' do
    it 'must raise error' do
      response, errors = formatted_response(query(123), key: :deleteUser)

      expect(response[:deleteUser]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query(id)
    <<~GQL
      mutation{
        deleteUser(
          input: {
            attributes: {
              id: "#{id}"#{' '}
            }#{'  '}
         }#{' '}
        )
      }
    GQL
  end
end
