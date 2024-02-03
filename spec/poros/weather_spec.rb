require "rails_helper"

RSpec.describe Weather do
  let(:weather_json) { File.read("spec/fixtures/boulder_weather_240130.json") }
  let(:weather) { Weather.new(JSON.parse(weather_json, symbolize_names: true)) }

  describe "initialize" do
    it "creates a weather object" do
      expect(weather).to be_a(Weather)
      expect(weather.date).to eq("Monday, January 29, 2024")
      expect(weather.current_temp).to eq(39.34)
      expect(weather.max_temp).to eq(45.25)
      expect(weather.min_temp).to eq(33.21)
      expect(weather.summary).to eq("clear sky")
    end
  end
end
