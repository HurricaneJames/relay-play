module RelayPlay
  Schema = GraphQL::Schema.new(query: RelayPlay::QueryType, mutation: RelayPlay::MutationType)
end