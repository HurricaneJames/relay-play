module RelayPlay
  module Types
    RegionType = GraphQL::ObjectType.define do
      name 'Region'

      field :name, !types.String
      connection :fairies, -> { RelayPlay::Types::FairyConnection }
    end
  end
end