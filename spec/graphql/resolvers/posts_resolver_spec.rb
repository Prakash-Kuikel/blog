# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::PostsResolver do
  let_it_be(:user) { create(:user) }
  let_it_be(:post1) { create(:post, user: user) }
  let_it_be(:post2) { create(:post, user: user) }

  context 'when queried without any filter' do
    let(:variables) do
      {
        first: 10
      }
    end

    it 'must return all posts' do
      expected_ids = Post.all.pluck(:id.to_s)
      response, errors = paginated_collection(:posts, query, variables: variables)

      expect(errors).to be_nil
      expect(response.pluck(:id).map(&:to_i)).to eq(expected_ids)
    end
  end

  context 'when filtered by created_at' do
    let(:variables) do
      {
        createdAt: '2022-08-22',
        first: 10
      }
    end

    it 'must return only posts created after given date' do
      expected_ids = Post.where('DATE(created_at) > ?',  '2022-08-22').pluck(:id)
      response, errors = paginated_collection(:posts, query, variables: variables)

      expect(errors).to be_nil
      expect(response.pluck(:id).map(&:to_i)).to eq(expected_ids)
    end
  end

  context 'when queried by a word' do
    let(:keyword) { post1.body.truncate_words(1, omission: '') }
    let(:variables) do
      {
        first: 10,
        keyword: keyword
      }
    end

    it 'must return the posts containing that word' do
      expected_ids = Post.where('body LIKE ?', "%#{keyword}%").pluck(:id)
      response, errors = paginated_collection(:posts, query, variables: variables)

      expect(errors).to be_nil
      expect(response.pluck(:id).map(&:to_i)).to eq(expected_ids)
    end
  end

  context 'when no matching post found' do
    let(:variables) do
      {
        createdAt: '2022-10-11',
        first: 10,
        keyword: 'RandomShit'
      }
    end

    it 'must return an empty list' do
      response, errors = paginated_collection(:posts, query, variables: variables)

      expect(errors).to be_nil
      expect(response).to be_empty
    end
  end

  def query
    <<~GQL
            query posts ($after: String, $before: String, $createdAt: String, $first: Int, $keyword: String, $last: Int) {
          posts (after: $after, before: $before, createdAt: $createdAt, first: $first, keyword: $keyword, last: $last) {
              edges {
                  cursor
                  node {
                      body
                      createdAt
                      id
                      userId
                  }
              }
              nodes {
                  body
                  createdAt
                  id
                  userId
              }
              pageInfo {
                  endCursor
                  hasNextPage
                  hasPreviousPage
                  startCursor
              }
          }
      }
    GQL
  end
end
