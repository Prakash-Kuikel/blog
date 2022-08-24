# frozen_string_literal: true

module Resolvers
  class PaginationBase < Resolvers::SearchObjectBase
    include SearchObject.module(:paging)
  end
end
