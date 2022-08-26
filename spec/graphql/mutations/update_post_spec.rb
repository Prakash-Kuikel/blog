# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Posts::Update do
  let_it_be(:user) { create(:user) }

  context 'when post exists' do
    let(:post) { create(:post, user: user) }

    let(:variables) do
      {
        input: {
          attributes: {
            id: post.id,
            body: Faker::Lorem.sentence
          }
        }
      }
    end

    it 'must update fields' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :updatePost)

      expect(errors).to be_nil
      expect(response[:updatePost]).to be_truthy
    end
  end

  context 'when post does not exist' do
    let(:variables) do
      {
        input: {
          attributes: {
            id: 123,
            body: Faker::Lorem.sentence
          }
        }
      }
    end

    it 'must raise an error' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :updatePost)

      expect(response[:updatePost]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: updatePostInput!){
        updatePost(input: $input)
      }
    GQL
  end
end
