# frozen_string_literal: true

module Mutations
  module Comments
    class Update < BaseMutation
      graphql_name 'updateComment'
      description 'Updates post of current user specified by ID'

      class UpdateCommentAttributes < Types::BaseInputObject
        argument :id, ID, required: true
        argument :body, String, required: true
      end

      argument :attributes, UpdateCommentAttributes, required: true
      type Boolean

      def resolve(attributes:)
        ::Comments::Updater.call(params: attributes.to_h, current_user: context[:current_user])
      end
    end
  end
end
