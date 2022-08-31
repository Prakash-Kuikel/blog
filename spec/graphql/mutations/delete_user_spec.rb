# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::Delete do
  let_it_be(:user) { create(:user) }

  context 'when user exists' do
    let(:variables) do
      {
        input: {
          attributes: {
            id: user.id
          }
        }
      }
    end

    it 'must destroy user and return the same' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :deleteUser)

      expect(errors).to be_nil
      expect(response[:deleteUser]).to be_truthy
    end
  end

  context 'when user does not exist' do
    let(:variables) do
      {
        input: {
          attributes: {
            id: 123
          }
        }
      }
    end

    it 'must raise error' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :deleteUser)

      expect(response[:deleteUser]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: deleteUserInput!){
        deleteUser(input: $input)
      }
    GQL
  end
end
