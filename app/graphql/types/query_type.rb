# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include MountQuery

    mount_query Resolvers::PostResolver, authorize: true
    mount_query Resolvers::PostsResolver

    mount_query Resolvers::CommentResolver
    mount_query Resolvers::CommentsResolver
  end
end
