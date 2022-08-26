# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::Update do
  context 'when user exists' do
    let(:user) { create(:user) }
    let(:variables) do
      {
        input: {
          attributes: {
            id: user.id,
            name: Faker::Name.name
          }
        }
      }
    end

    it 'must update fields' do
      response, errors = formatted_response(query, variables: variables, key: :updateUser)

      expect(errors).to be_nil
      expect(response[:updateUser]).to be_truthy
    end
  end

  context 'when user does not exist' do
    let(:variables) do
      {
        input: {
          attributes: {
            id: 123,
            name: Faker::Name.name,
            email: Faker::Internet.email
          }
        }
      }
    end

    it 'must raise an error' do
      response, errors = formatted_response(query, variables: variables, key: :updateUser)

      expect(response[:updateUser]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: updateUserInput!){
        updateUser(input: $input)
      }
    GQL
  end
end
