# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Comments::Create do
  let_it_be(:user) { create(:user) }
  let_it_be(:post) { create(:post, user: user) }

  context 'when post exists' do
    let(:variables) do
      {
        input: {
          attributes: {
            body: Faker::Lorem.sentence,
            postId: post.id
          }
        }
      }
    end

    it 'must create comment and return the same' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :createComment)

      expect(errors).to be_nil
      expect(response[:createComment][:body]).to eq(variables[:input][:attributes][:body])
    end
  end

  context 'when post does not exist' do
    let(:variables) do
      {
        input: {
          attributes: {
            body: Faker::Lorem.sentence,
            postId: 123
          }
        }
      }
    end

    it 'must raise error' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :createComment)

      expect(response[:createComment]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: createCommentInput!){
        createComment(input: $input){
          body
        }
      }
    GQL
  end
end
