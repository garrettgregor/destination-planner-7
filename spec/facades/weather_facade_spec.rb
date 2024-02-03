require "rails_helper"

RSpec.describe WeatherFacade do
  describe "#current_weather_in" do
    let(:facade) { WeatherFacade.new }

    it "returns current weather in a given zipcode" do
      boulder_weather_json = File.read("spec/fixtures/boulder_weather_240130.json")
      boulder_weather_url = "https://api.openweathermap.org/data/2.5/weather?lat=40.0497&lon=-105.2143&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial"

      boulder_coords_json = File.read("spec/fixtures/boulder_lat_lon.json")
      boulder_coords_url = "http://api.openweathermap.org/geo/1.0/zip?zip=80301"

      stub_request(:get, boulder_weather_url)
        .to_return(status: 200, body: boulder_weather_json, headers: {})

      stub_request(:get, boulder_coords_url)
        .to_return(status: 200, body: boulder_coords_json, headers: {})

      zipcode = "80301"
      weather = facade.current_weather_in(zipcode)

      expect(weather).to be_a(Weather)
      expect(weather.date).to eq("Monday, January 29, 2024")
      expect(weather.current_temp).to eq(39.34)
      expect(weather.max_temp).to eq(45.25)
      expect(weather.min_temp).to eq(33.21)
      expect(weather.summary).to eq("clear sky")
    end
  end
end
