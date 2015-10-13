module RelayPlay
  module Types
    TalentType = GraphQL::ObjectType.define do
      name 'Talent'

      field :name, !types.String
      field :fairies, -> { types[RelayPlay::Types::FairyType] }
    end
  end
end