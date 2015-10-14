module RelayPlay
  module Types
    FairyConnection = GraphQL::Relay::RelationConnection.create_type(RelayPlay::Types::FairyType)
  end
end