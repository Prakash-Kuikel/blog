# frozen_string_literal: true

module Mutations
  module Posts
    class Update < BaseMutation
      graphql_name 'updatePost'
      description 'Updates post of current user specified by ID'

      class UpdatePostAttributes < Types::BaseInputObject
        argument :id, ID, required: true
        argument :body, String, required: true
      end

      argument :attributes, UpdatePostAttributes, required: true
      type Boolean

      def resolve(attributes:)
        ::Posts::Updater.call(params: attributes.to_h, current_user: context[:current_user])
      end
    end
  end
end
