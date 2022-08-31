# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::CommentsResolver do
  let_it_be(:user1) { create(:user) }
  let_it_be(:user2) { create(:user) }
  let_it_be(:post1) { create(:post, user: user1) }
  let_it_be(:post2) { create(:post, user: user2) }
  let_it_be(:comment1) { create(:comment, post: post1, user: user2) }
  let_it_be(:comment2) { create(:comment, post: post2, user: user1) }

  let(:variables) do
    {
      createdAt: '',
      first: 10,
      keyword: '',
      postId: 0,
      userId: 0
    }
  end

  context 'when queried with no filters' do
    let(:variables) do
      {
        first: 10
      }
    end

    it 'must return all comments' do
      expected_ids = Comment.all.pluck(:id)
      response, errors = paginated_collection(:comments, query, variables: variables)

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

    it 'must return only comments after given date' do
      expected_ids = Comment.where('DATE(created_at) > ?', '2022-08-22').pluck(:id)
      response, errors = paginated_collection(:comments, query, variables: variables)

      expect(errors).to be_nil
      expect(response.pluck(:id).map(&:to_i)).to eq(expected_ids)
    end
  end

  context 'when filtered by user_id' do
    let(:variables) do
      {
        first: 10,
        userId: user1.id
      }
    end

    it 'must return only comments by given user' do
      expected_ids = Comment.where(user_id: user1.id).pluck(:id)
      response, errors = paginated_collection(:comments, query, variables: variables)

      expect(errors).to be_nil
      expect(response.pluck(:id).map(&:to_i)).to eq(expected_ids)
    end
  end

  context 'when filtered by post_id' do
    let(:variables) do
      {
        first: 10,
        postId: post1.id
      }
    end

    it 'must return only comments of given post' do
      expected_ids = Comment.where(post_id: post1.id).pluck(:id)
      response, errors = paginated_collection(:comments, query, variables: variables)

      expect(errors).to be_nil
      expect(response.pluck(:id).map(&:to_i)).to eq(expected_ids)
    end
  end

  context 'when queried using a word' do
    let(:variables) do
      {
        first: 10,
        keyword: comment1.body.truncate_words(1, omission: '')
      }
    end

    it 'must return comments containing that word' do
      expected_ids = Comment.where('body LIKE ?', "%#{comment1.body.truncate_words(1, omission: '')}%").pluck(:id)
      response, errors = paginated_collection(:comments, query, variables: variables)

      expect(errors).to be_nil
      expect(response.pluck(:id).map(&:to_i)).to eq(expected_ids)
    end
  end

  context 'when no matching comment found' do
    let(:variables) do
      {
        first: 10,
        keyword: 'someRandomShit'
      }
    end

    it 'must return empty list' do
      response, errors = paginated_collection(:comments, query, variables: variables)

      expect(errors).to be_nil
      expect(response).to be_empty
    end
  end

  def query
    <<~GQL
            query comments ($after: String, $before: String, $createdAt: String, $first: Int, $keyword: String, $last: Int, $postId: ID, $userId: ID) {
          comments (after: $after, before: $before, createdAt: $createdAt, first: $first, keyword: $keyword, last: $last, postId: $postId, userId: $userId) {
              edges {
                  cursor
                  node {
                      body
                      createdAt
                      id
                      postId
                      userId
                  }
              }
              nodes {
                  body
                  createdAt
                  id
                  postId
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
