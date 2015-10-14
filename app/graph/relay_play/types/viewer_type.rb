module RelayPlay
  module Types
    ViewerType = GraphQL::ObjectType.define do
      name 'Viewer'
      description 'A viewer to support lists on root node because Relay currently requires a single root element'

      connection :fairies, -> { RelayPlay::Types::FairyConnection } do
        resolve -> (obj, args, ctx) {
          Fairy.all
        }
      end
    end

    ViewerConnection = GraphQL::Relay::RelationConnection.create_type(ViewerType)
  end
end