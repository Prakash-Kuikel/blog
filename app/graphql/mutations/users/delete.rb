# frozen_string_literal: true

module Mutations
  module Users
    class Delete < BaseMutation
      graphql_name 'DeleteUser'
      description 'Deletes user based on id'

      class UserDeleteAttributes < Types::BaseInputObject
        argument :id, ID, required: true
      end

      argument :attributes, UserDeleteAttributes, required: true

      type Boolean

      def resolve(attributes:)
        ::Users::Deleter.call(attributes)
      end
    end
  end
end
