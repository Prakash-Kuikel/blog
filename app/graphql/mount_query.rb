# frozen_string_literal: true

module MountQuery
  extend ActiveSupport::Concern

  class_methods do
    def mount_query(query_klass, **custom_kwargs)
      # Using an underscored field name symbol will make `graphql-ruby`
      # standardize the field name
      field(
        query_klass.graphql_name.underscore.to_sym,
        resolver: query_klass,
        **custom_kwargs
      )
    end
  end
end
