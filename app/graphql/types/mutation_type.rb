# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    mount_mutation Mutations::Users::Create
  end
end
