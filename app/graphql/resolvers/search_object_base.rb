# frozen_string_literal: true

require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
  class SearchObjectBase < Resolvers::BaseResolver
    include SearchObject.module(:graphql)
  end
end
