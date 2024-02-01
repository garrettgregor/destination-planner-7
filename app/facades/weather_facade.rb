class WeatherFacade
  def current_weather_in(zipcode)
    coordinates = service.coordinates(zipcode.slice(0, 5))
    latitude = coordinates[:lat]
    longitude = coordinates[:lon]

    data = service.get_weather_for(latitude, longitude)

    @destination_weather = Weather.new(data)
  end

  private

  def service
    WeatherService.new
  end
end
