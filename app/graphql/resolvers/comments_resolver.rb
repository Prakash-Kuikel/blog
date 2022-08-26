# frozen_string_literal: true

module Resolvers
  class CommentsResolver < SearchObjectBase
    graphql_name 'comments'
    description 'Returns multiple comments based on filters'

    type Types::CommentType.connection_type, null: false

    scope { Comment.all }

    option(:created_at, type: String) { |scope, value| scope.where('DATE(created_at) > ?', value) }
    option(:user_id, type: ID) { |scope, value| scope.where(user_id: value) }
    option(:post_id, type: ID) { |scope, value| scope.where(post_id: value) }
    option(:keyword, type: String) { |scope, value| scope.where('body LIKE ?', "%#{value}%") }
  end
end
