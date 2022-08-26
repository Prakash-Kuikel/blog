# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    include MountMutation

    mount_mutation Mutations::Users::Create
    mount_mutation Mutations::Users::Delete

    mount_mutation Mutations::Users::Update
  end
end
