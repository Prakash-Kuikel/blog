# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :created_at, String, null: false
    field :user_id, ID, null: false
  end
end
