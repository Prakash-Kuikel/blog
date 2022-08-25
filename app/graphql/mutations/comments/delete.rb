# frozen_string_literal: true

module Mutations
  module Comments
    class Delete < BaseMutation
      graphql_name 'deleteComment'
      description 'Deletes comment by owner of post or comment, specified by id'

      class DeleteCommentAttributes < Types::BaseInputObject
        argument :id, ID, required: true
      end

      argument :attributes, DeleteCommentAttributes, required: true
      type Boolean

      def resolve(attributes:)
        ::Comments::Deleter.call(params: attributes.to_h, current_user: context[:current_user])
      end
    end
  end
end
