# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::Create do
  context 'with valid params' do
    let(:variables) do
      {
        input: {
          attributes: {
            name: Faker::Name.name,
            email: Faker::Internet.email
          }
        }
      }
    end

    it 'returns new user' do
      response, errors = formatted_response(query, variables: variables, key: :createUser)

      expect(errors).to be_nil
      expect(response[:createUser]).to match(variables[:input][:attributes])
    end
  end

  context 'with invalid params' do
    let(:variables) do
      {
        input: {
          attributes: {
            name: '',
            email: 'not_an_email'
          }
        }
      }
    end

    it 'raises error' do
      response, errors = formatted_response(query, variables: variables, key: :createUser)

      expect(response[:createUser]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: createUserInput!){
        createUser(input: $input){
          name
          email
        }
      }
    GQL
  end
end
