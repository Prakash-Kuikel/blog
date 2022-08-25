# frozen_string_literal: true

module Resolvers
  class PostResolver < BaseResolver
    graphql_name 'post'
    description 'Returns a post specified by ID'

    argument :id, ID, required: true
    type Types::PostType, null: false

    def resolve(id:)
      Post.find(id)
    end
  end
end
