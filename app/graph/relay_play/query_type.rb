module RelayPlay
  QueryType = GraphQL::ObjectType.define do
    name "Queries"
    description "The query root for this schema"

    field :node, field: RelayPlay::NodeIdentification.field

    field :viewer do
      type RelayPlay::Types::ViewerType
      description "A fairy world viewer"
      resolve -> (obj, args, ctx) do
        {}
      end
    end

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