# frozen_string_literal: true

module Resolvers
  class PostsResolver < SearchObjectBase
    graphql_name 'posts'
    description 'Returns all posts'

    type Types::PostType.connection_type, null: false

    scope { Post.all }

    option(:created_at, type: String) { |scope, value| scope.where('DATE(created_at) > ?', value) }
    option(:keyword, type: String) { |scope, value| scope.where('body LIKE ?', "%#{value}%") }
  end
end
