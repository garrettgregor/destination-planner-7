require "rails_helper"

RSpec.describe WeatherService do
  describe "#coordinates" do
    let(:service) { WeatherService.new }

    it "parses a json response with a given zip code", :vcr do
      query = "80301"

      result = service.coordinates(query)

      expect(result).to be_a(Hash)
      expect(result[:zip]).to eq("80301")
      expect(result[:name]).to eq("Boulder County")
      expect(result[:lat]).to eq(40.0497)
      expect(result[:lon]).to eq(-105.2143)
      expect(result[:country]).to eq("US")
    end
  end

  describe "#get_weather_for" do
    let(:service) { WeatherService.new }

    it "parses a json response with a given zip code" do
      latitude = "40.0497"
      longitude = "-105.2143"

      boulder_weather_json = File.read("spec/fixtures/boulder_weather_240130.json")
      boulder_weather_url = "https://api.openweathermap.org/data/2.5/weather?lat=40.0497&lon=-105.2143&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial"

      stub_request(:get, boulder_weather_url)
        .to_return(status: 200, body: boulder_weather_json, headers: {})

      result = service.get_weather_for(latitude, longitude)

      expect(result).to be_a(Hash)
      expect(result[:dt]).to eq(1706592983)
      expect(result[:main][:temp]).to eq(39.34)
      expect(result[:main][:temp_min]).to eq(33.21)
      expect(result[:main][:temp_max]).to eq(45.25)
      expect(result[:weather].first[:description]).to eq("clear sky")
    end
  end
end
