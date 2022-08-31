# frozen_string_literal: true

module Resolvers
  class CommentResolver < BaseResolver
    graphql_name 'comment'
    description 'Returns comment based on ID'

    argument :id, ID, required: true
    type Types::CommentType, null: false

    def resolve(id:)
      Comment.find(id)
    end
  end
end
