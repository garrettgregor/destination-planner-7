class ImageService
  def get_image_data(descriptor)
    get_url("https://api.giphy.com/v1/gifs/search?&q=#{descriptor}&limit=1&offset=0&rating=g&lang=en&bundle=messaging_non_clips")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new do |f|
      f.params["api_key"] = ENV["GIPHY_API_KEY"]
    end
  end
end
