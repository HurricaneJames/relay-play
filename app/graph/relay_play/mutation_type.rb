module RelayPlay
  MutationType = GraphQL::ObjectType.define do
    name "Mutations"
    description "The mutation root for this schema"

    field :moveFairy, field: RelayPlay::Mutations::MoveFairyMutation.field

  end
end