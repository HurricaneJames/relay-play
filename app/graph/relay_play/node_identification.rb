module RelayPlay
  NodeIdentification = GraphQL::Relay::GlobalNodeIdentification.define do
    object_from_id -> (id) do
      type_name, id = NodeIdentification.from_global_id(id)
      model = type_name.capitalize.constantize
      model.where(id: id).first
    end

    type_from_object -> (object) do
      "RelayPlay::Types::#{object.class.name}Type".constantize
    end
  end
end