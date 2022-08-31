# frozen_string_literal: true

def execute(query, current_user: nil, variables: nil)
  HashWithIndifferentAccess.new(
    BlogSchema.execute(query,
                       context: { current_user: current_user }, variables: variables).as_json
  )
end

# For Queries
# When you pass a key, your expectation should read as
#   :=> users, errors = formatted_response.... where key: users
# Without the key it should read as
#   :=> data, errors = formatted_response...
#
# For Mutations
# You will mostly be passing the key, so your expectation can look like
#   :=> response, errors = formatted_response...
# where response will either be a boolean flag or an object based on what is returned
def formatted_response(query, current_user: nil, key: nil, variables: nil)
  response = execute(query, current_user: current_user, variables: variables)
  data = response[:data]
  [RecursiveOpenStruct.new(key ? data[key] : data), response[:errors]]
rescue StandardError
  [response[:data], response.dig(:errors, 0, :message)] # for easier debugging during failures
end

def paginated_collection(node, query_string, current_user: nil, variables: nil)
  response = execute(query_string, current_user: current_user, variables: variables)
  [response.dig(:data, node, :edges)&.pluck(:node), response[:errors]]
rescue StandardError
  error = response.dig(:errors, 0)

  ap case error.class
     when Hash
       error[:message]
     else
       error
     end
end

# def graphql_response(klass, users, params = {})
#   resolver = klass.new(field: nil, object: nil, context: { current_user: users })
#   query(resolver, **params)
# rescue StandardError => e
#   record = e.try(:record)
#   errors = record.try(:errors).present? ? record.errors.full_messages.to_sentence : e.message
#   [nil, errors]
# end
#
# def query(resolver, **params)
#   response = if resolver.class.include?(SearchObject::Base)
#                params.blank? ? resolver.resolve_with_support : resolver.resolve_with_support(**params)
#              else
#                params.blank? ? resolver.resolve : resolver.resolve(**params)
#              end
#   [response, nil]
# end

# Formats the given input hash to a GraphQL string.
# Pass the default required key values for a given spec file in a block to avoid
# passing it in every query param. eg.
#   super { { projectId: project.id } }
#
# @param [Hash] params Keyword arguments
# @param [String]
def query_string(params)
  params.merge!(yield) if block_given?
  return if params.blank?

  array = params.reduce([]) do |arr, param|
    key, value = param
    formatted = value.is_a?(String) ? "\"#{value}\"" : value
    arr << "#{key.to_s.camelize(:lower)}:#{formatted}"
  end

  array.try { |item| "(#{item.join(',')})" }
end

def connection_query(request, response, meta: nil)
  <<~GQL
    query {
      #{request} {
        #{meta}
        edges {
          node {
            #{response}
          }
        }
        pageInfo {
          endCursor
          startCursor
          hasNextPage
          hasPreviousPage
        }
      }
    }
  GQL
end
