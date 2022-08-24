# frozen_string_literal: true

module Mutations
  module Posts
    class Delete < BaseMutation
      graphql_name 'deletePost'
      description 'Deletes post specified by id'

      class DeletePostAttributes < Types::BaseInputObject
        argument :id, ID, required: true
      end

      argument :attributes, DeletePostAttributes, required: true
      type Boolean

      def resolve(attributes:)
        ::Posts::Deleter.call(params: attributes.to_h, current_user: context[:current_user])
      end
    end
  end
end
