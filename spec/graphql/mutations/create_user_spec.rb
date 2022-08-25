# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::Create do
  describe 'with valid params' do
    let(:params) do
      {
        name: 'Prakash',
        email: 'pk@selise.ch'
      }
    end

    let(:expected_response) do
      {
        name: 'Prakash',
        email: 'pk@selise.ch'
      }
    end

    it 'returns new user' do
      response, errors = formatted_response(query(params), key: :createUser)

      expect(errors).to be_nil
      expect(response[:createUser]).to match(expected_response)
    end
  end

  describe 'with invalid params' do
    let(:params) do
      {
        name: '',
        email: 'not_an_email'
      }
    end

    it 'raises error' do
      response, errors = formatted_response(query(params), key: :createUser)

      expect(response[:createUser]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query(args = {})
    <<~GQL
      mutation {
        createUser(
          input: {
            attributes: {
              name: "#{args[:name]}"
              email: "#{args[:email]}"
            }
          }
        ){
          name
          email
        }
      }
    GQL
  end
end
