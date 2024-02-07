class DestinationSerializer
  include JSONAPI::Serializer

  attributes :name, :zip, :description, :image_url
end
