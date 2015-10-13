module RelayPlay
  module Mutations
    MoveFairyMutation = GraphQL::Relay::Mutation.define do
      name 'MoveFairy'

      input_field :fairyId,  !types.ID
      input_field :regionId, !types.ID

      return_field :fairy,  RelayPlay::Types::FairyType  
      return_field :region, RelayPlay::Types::RegionType 

      resolve -> (inputs, ctx) {
        fairy = Fairy.where(id: inputs["fairyId"]).first
        fairy.region = Region.where(id: inputs["regionId"]).first
        fairy.save!
        { fairy: fairy, region: fairy.region }
      }
    end
  end
end
