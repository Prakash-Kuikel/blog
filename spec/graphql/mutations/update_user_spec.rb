# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::Update do
  context 'when user exists' do
    let(:user) { create(:user) }
    let(:params) do
      {
        id: user.id,
        name: Faker::Name.name,
        email: Faker::Internet.email
      }
    end

    it 'must update fields' do
      response, errors = formatted_response(query(params), key: :updateUser)

      expect(errors).to be_nil
      expect(response[:updateUser]).to be_truthy
    end
  end

  context 'when user does not exist' do
    let(:params) do
      {
        id: 123,
        name: Faker::Name.name,
        email: Faker::Internet.email
      }
    end

    it 'must raise an error' do
      response, errors = formatted_response(query(params), key: :updateUser)

      expect(response[:updateUser]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query(args = {})
    <<~GQL
      mutation{
        updateUser(
          input: {
            attributes: {
              id: "#{args[:id]}"
              name: "#{args[:name]}"
              email: "#{args[:email]}"
            }
          }
        )
      }
    GQL
  end
end
