module RelayPlay
  QueryType = GraphQL::ObjectType.define do
    name "Queries"
    description "The query root for this schema"

    field :node, field: RelayPlay::NodeIdentification.field

    # Relay Way
    # Relay does not currently support anything but single root nodes
    # so viewer is a hack to give us an Object type that encapsulates
    # the fairies index
    field :viewer do
      type RelayPlay::Types::ViewerType
      description "A fairy world viewer (relay hack to get at fairies)"
      resolve -> (obj, args, ctx) do
        {}
      end
    end

    # straight graphql way
    # notice
    #   - that only returns the fairies
    #   - that it does not come with the automatic pagination stuff
    field :fairies do
      type types[ RelayPlay::Types::FairyType ]
      description "Fairies"
      argument :first, types.Int

      resolve -> (obj, args, ctx) do
        if(args["first"]) 
          Fairy.limit(args["first"])
        else
          Fairy.all
        end
      end
    end
  end
end