module RelayPlay
  MutationType = GraphQL::ObjectType.define do
    name "Mutations"
    description "The mutation root for this schema"

    field :moveFairy do
      type RelayPlay::Types::FairyType

      argument :fairyId, !types.Int
      argument :regionId, !types.Int

      resolve -> (obj, args, ctx) do
        fairy = Fairy.where(id: args["fairyId"]).first
        fairy.region = Region.where(id: args["regionId"]).first
        fairy.save!
        fairy
      end
    end
  end
end