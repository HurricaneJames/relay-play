module RelayPlay
  QueryType = GraphQL::ObjectType.define do
    name "Queries"
    description "The query root for this schema"

    field :fairies do
      type types[ RelayPlay::Types::FairyType ]
      description "Fairies"
      resolve -> (obj, args, ctx) do
        Fairy.all
      end
    end
  end
end