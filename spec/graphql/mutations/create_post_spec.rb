require 'rails_helper'

RSpec.describe Mutations::Posts::Create do
  let_it_be(:user) { create(:user)}

  describe 'with valid params' do
    let(:variables) do
      {
        input: {
          attributes: {
            body: Faker::Lorem.sentence
          }
        }
      }
    end

    it 'must create and return new post' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :createPost)

      expect(errors).to be_nil
      expect(response[:createPost]).to match(variables[:input][:attributes])
    end
  end

  describe 'with invalid params' do
    let(:variables) do
      {
        input: {
          attributes: {
            body: ''
          }
        }
      }
    end

    it 'must return error' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :createPost)

      expect(response[:createPost]).to be_nil
      !expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: createPostInput!){
        createPost(input: $input){
          body
        }
      }
    GQL
  end
end