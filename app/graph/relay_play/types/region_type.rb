module RelayPlay
  module Types
    RegionType = GraphQL::ObjectType.define do
      name 'Region'

      field :name, !types.String
      field :fairies, -> { types[RelayPlay::Types::FairyType] }
    end
  end
end