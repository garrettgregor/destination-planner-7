class DestinationSerializer
  include JSONAPI::Serializer

  attributes :name, :zip, :description, :image_url

  def self.serialize_with_info(destination, weather, gif) # rubocop:disable Metrics/MethodLength
    {
      data: {
        id: destination.id.to_s,
        type: "destination",
        attributes: {
          name: destination.name,
          description: destination.description,
          zip: destination.zip,
          image_url: destination.image_url
        },
        weather: {
          current_temp: weather.current_temp.to_s,
          max_temp: weather.max_temp.to_s,
          min_temp: weather.min_temp.to_s,
          summary: weather.summary
        },
        gif: {
          gif_url: gif.url
        }
      }
    }
  end
end
