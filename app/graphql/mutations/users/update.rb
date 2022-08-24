# frozen_string_literal: true

module Mutations
  module Users
    class Update < BaseMutation
      graphql_name 'updateUser'
      description 'Updates details of user specified by ID'

      argument :attributes, Attributes::Users::Update, required: true
      type Boolean

      def resolve(attributes:)
        ::Users::Updater.call(params: attributes.to_h)
      end
    end
  end
end
