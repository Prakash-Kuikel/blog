# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::PostResolver do
  let_it_be(:user) { create(:user) }
  let_it_be(:post) { create(:post, user: user) }

  context 'when post exists' do
    let(:variable) do
      {
        id: post.id
      }
    end

    it 'must return post' do
      response, errors = formatted_response(query, variables: variable, current_user: user, key: :post)

      expect(errors).to be_nil
      expect(response[:post][:body]).to eq(post.body)
    end
  end

  context 'when post does not exist' do
    let(:variable) do
      {
        id: 123
      }
    end

    it 'must raise error' do
      response, errors = formatted_response(query, variables: variable, current_user: user, key: :post)

      expect(response).to be_nil
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      query($id: ID!){
        post(id: $id){
          body
        }
      }
    GQL
  end
end
