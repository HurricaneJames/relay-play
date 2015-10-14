module RelayPlay
  module Types

    ViewerType = GraphQL::ObjectType.define do
      name 'Viewer'
      description 'A viewer to support lists on root node because Relay currently requires a single root element'

      connection :fairies, -> { RelayPlay::Types::FairyConnection } do
        resolve -> (obj, args, ctx) {
          # Rails 3.x
          # Fairy.scoped

          # Rails 4.x
          Fairy.all
        }
      end
    end

  end
end