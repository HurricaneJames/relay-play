module RelayPlay
  module Types
    FairyType = GraphQL::ObjectType.define do
      name 'Fairy'

      field :name, !types.String

      field :talent, -> { !RelayPlay::Types::TalentType }
      field :region, -> { !RelayPlay::Types::RegionType }
    end
  end
end