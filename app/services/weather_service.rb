class WeatherService
  def coordinates(zip)
    get_url("http://api.openweathermap.org/geo/1.0/zip?zip=#{zip}")
  end

  def get_weather_for(latitude, longitude)
    get_url("https://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&units=imperial")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new do |f|
      f.params["appid"] = ENV["OPEN_WEATHER_API_KEY"]
    end
  end
end
