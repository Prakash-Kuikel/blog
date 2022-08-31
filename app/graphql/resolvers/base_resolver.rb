# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include GraphqlHelper
    include ActionPolicy::GraphQL::Behaviour
  end
end
