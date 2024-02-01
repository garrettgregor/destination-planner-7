require "rails_helper"

RSpec.describe "Show", type: :feature do
  let!(:destination1) { Destination.create(name: "Boulder", zip: "80301", description: "Mile High City", image_url: "https://via.placeholder.com/300x300.png") }
  let!(:destination2) { Destination.create(name: "New York", zip: "10001", description: "Big Apple", image_url: "https://via.placeholder.com/300x300.png") }

  before(:each) do
    boulder_weather_json = File.read("spec/fixtures/boulder_weather_240130.json")
    boulder_weather_url = "https://api.openweathermap.org/data/2.5/weather?lat=40.0497&lon=-105.2143&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial"

    boulder_coords_json = File.read("spec/fixtures/boulder_lat_lon.json")
    boulder_coords_url = "http://api.openweathermap.org/geo/1.0/zip?zip=80301"

    stub_request(:get, boulder_weather_url)
      .to_return(status: 200, body: boulder_weather_json, headers: {})

    stub_request(:get, boulder_coords_url)
      .to_return(status: 200, body: boulder_coords_json, headers: {})

    visit destination_path(destination1)
  end

  describe "welcome page" do
    it "takes me to a page with a list of destinations" do
      expect(page).to have_content("Boulder")
      expect(page).to have_content("80301")
      expect(page).to have_content("Mile High City")

      expect(page).to_not have_content("New York")
      expect(page).to_not have_content("10001")
      expect(page).to_not have_content("Big Apple")

      within "#forecast-Boulder" do
        expect(page).to have_content("Date: Monday, January 29, 2024")
        expect(page).to have_content("Current: 39.34 Degrees")
        expect(page).to have_content("High: 45.25 Degrees")
        expect(page).to have_content("Low: 33.21 Degrees")
        expect(page).to have_content("Summary: clear sky")
      end
    end
  end
end
