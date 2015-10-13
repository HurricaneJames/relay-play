module RelayPlay
  module Types
    FairyType = GraphQL::ObjectType.define do
      name 'Fairy'
      interfaces [RelayPlay::NodeIdentification.interface]

      global_id_field :id
      field :name, !types.String

      field :talent, -> { !RelayPlay::Types::TalentType }
      field :region, -> { !RelayPlay::Types::RegionType }

      # field :friends, -> { types[RelayPlay::Types::FairyType] }
      connection :friends, -> { RelayPlay::Types::FairyConnection }
    end

    FairyConnection = GraphQL::Relay::RelationConnection.create_type(FairyType)
  end
end