# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    mount_mutation Mutations::Users::Create
    mount_mutation Mutations::Users::Delete
  end
end
