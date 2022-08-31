# frozen_string_literal: true

module Mutations
  module Users
    class Delete < BaseMutation
      graphql_name 'deleteUser'
      description 'Deletes user based on id'

      class UserDeleteAttributes < Types::BaseInputObject
        argument :id, ID, required: true
      end

      argument :attributes, UserDeleteAttributes, required: true
      type Boolean

      def resolve(attributes:)
        ::Users::Deleter.call(params: attributes.to_h, current_user: context[:current_user])
      end
    end
  end
end
