module RelayPlay
  QueryType = GraphQL::ObjectType.define do
    name "Queries"
    description "The query root for this schema"
    field :butterfly do
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