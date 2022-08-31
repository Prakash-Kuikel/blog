# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::CommentResolver do
  let_it_be(:user) { create(:user) }
  let_it_be(:post) { create(:post, user: user) }
  let_it_be(:comment) { create(:comment, post: post, user: user) }

  context 'when comment exists' do
    let(:variable) do
      {
        id: comment.id
      }
    end

    it 'must return comment' do
      response, errors = formatted_response(query, variables: variable, current_user: user, key: :comment)

      expect(errors).to be_nil
      expect(response[:comment][:body]).to eq(comment.body)
    end
  end

  context 'when comment does not exist' do
    let(:variable) do
      {
        id: 123
      }
    end

    it 'must raise error' do
      response, errors = formatted_response(query, variables: variable, current_user: user, key: :comment)

      expect(response).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      query($id: ID!){
        comment(id: $id){
          body
        }
      }
    GQL
  end
end
