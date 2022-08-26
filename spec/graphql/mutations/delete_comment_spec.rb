# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Comments::Delete do
  let_it_be(:user) { create(:user) }
  let_it_be(:post) { create(:post, user: user) }
  let_it_be(:comment) { create(:comment, post: post, user: user) }

  context 'when comment exists' do
    let(:variables) do
      {
        input: {
          attributes: {
            id: comment.id
          }
        }
      }
    end

    it 'must delete comment' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :deleteComment)

      expect(errors).to be_nil
      expect(response[:deleteComment]).to be_truthy
    end
  end

  context 'when post does not exist' do
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
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :deletePost)

      expect(response[:deleteComment]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: deleteCommentInput!){
        deleteComment(input: $input)
      }
    GQL
  end
end
