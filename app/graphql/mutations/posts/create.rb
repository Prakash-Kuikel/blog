# frozen_string_literal: true

module Mutations
  module Posts
    class Create < BaseMutation
      graphql_name 'createPost'
      description 'Creates new post by current user'

      class CreatePostAttributes < Types::BaseInputObject
        argument :body, String, required: true
      end

      argument :attributes, CreatePostAttributes, required: true
      type Types::PostType

      def resolve(attributes:)
        ::Posts::Creator.call(params: attributes.to_h, current_user: context[:current_user])
      end
    end
  end
end
