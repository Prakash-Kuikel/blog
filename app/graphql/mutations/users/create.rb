# frozen_string_literal: true

module Mutations
  module Users
    class Create < BaseMutation
      graphql_name 'createUser'
      description 'Creates and returns new user'

      argument :attributes, Attributes::Users::Create, required: true
      type Types::UserType

      def resolve(attributes:)
        ::Users::Creator.call(params: attributes.to_h)
      end
    end
  end
end
