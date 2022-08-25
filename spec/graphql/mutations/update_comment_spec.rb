# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Comments::Update do
  let_it_be(:user) { create(:user) }
  let_it_be(:post) { create(:post, user: user) }

  context 'when comment exists' do
    let(:comment) { create(:comment, post: post, user: user) }

    let(:variables) do
      {
        input: {
          attributes: {
            id: comment.id,
            body: Faker::Lorem.sentence
          }
        }
      }
    end

    it 'must update fields' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :updateComment)

      expect(errors).to be_nil
      expect(response[:updateComment]).to be_truthy
    end
  end

  context 'when comment does not exist' do
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
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :updateComment)

      expect(response[:updateComment]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: updateCommentInput!){
        updateComment(input: $input)
      }
    GQL
  end
end
