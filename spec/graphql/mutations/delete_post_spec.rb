# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Posts::Delete do
  let_it_be(:user) { create(:user) }

  context 'when post exists' do
    let(:post) { create(:post, user: user) }
    let(:variables) do
      {
        input: {
          attributes: {
            id: post.id
          }
        }
      }
    end

    it 'must delete post' do
      response, errors = formatted_response(query, variables: variables, current_user: user, key: :deletePost)

      expect(errors).to be_nil
      expect(response[:deletePost]).to be_truthy
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

      expect(response[:deletePost]).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation($input: deletePostInput!){
        deletePost(input: $input)
      }
    GQL
  end
end
