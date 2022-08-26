# frozen_string_literal: true

module Mutations
  module Comments
    class Create < BaseMutation
      graphql_name 'createComment'
      description 'Creates a new comment by current user on a post specified by ID'

      class CreateCommentAttributes < Types::BaseInputObject
        argument :post_id, ID, required: true
        argument :body, String, required: true
      end

      argument :attributes, CreateCommentAttributes, required: true
      type Types::CommentType

      def resolve(attributes:)
        ::Comments::Creator.call(params: attributes.to_h, current_user: context[:current_user])
      end
    end
  end
end
