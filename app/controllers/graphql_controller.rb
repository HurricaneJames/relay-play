class GraphqlController < ApplicationController
  layout false

  def exec
    query_string = params[:query]
    query_variables = params[:variables] || {}

    query = GraphQL::Query.new(RelayPlay::Schema, query_string, variables: query_variables)
    render json: query.result
  end

  def graphiql
  end
end