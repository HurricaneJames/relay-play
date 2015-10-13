module RelayPlay
  module Types
    TalentType = GraphQL::ObjectType.define do
      name 'Talent'

      field :name, !types.String
      connection :fairies, -> { RelayPlay::Types::FairyConnection }
    end
  end
end