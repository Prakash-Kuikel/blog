# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    include MountMutation

    mount_mutation Mutations::Users::Create
    mount_mutation Mutations::Users::Delete
    mount_mutation Mutations::Users::Update

    mount_mutation Mutations::Posts::Create
    mount_mutation Mutations::Posts::Delete
    mount_mutation Mutations::Posts::Update
  end
end
