module RelayPlay
  MutationType = GraphQL::ObjectType.define do
    name "Mutations"
    description "The mutation root for this schema"
    field :watchButterfly do
      type types.String
      description "demo"
      argument :number, types.Int, "[optional] number"
      resolve -> (obj, args, ctx) do
        butterfly = "butterfly"
        butterfly += args["number"] if args["number"].present?
        butterfly
      end
    end
  end
end