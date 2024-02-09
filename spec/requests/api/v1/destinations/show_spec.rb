require "rails_helper"

RSpec.describe "GET /destination/:id" do
  let!(:destination_1) { create(:destination, zip: "80301") }
  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  before(:each) do
    boulder_weather_json = File.read("spec/fixtures/boulder_weather_240130.json")
    boulder_weather_url = "https://api.openweathermap.org/data/2.5/weather?lat=40.0497&lon=-105.2143&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial"

    boulder_coords_json = File.read("spec/fixtures/boulder_lat_lon.json")
    boulder_coords_url = "http://api.openweathermap.org/geo/1.0/zip?zip=80301"

    giphy_json = File.read("spec/fixtures/clear_sky_giphy.json")
    giphy_url = "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=clear sky&limit=1&offset=0&rating=g&lang=en&bundle=messaging_non_clips" # rubocop:disable Layout/LineLength

    stub_request(:get, boulder_weather_url)
      .to_return(status: 200, body: boulder_weather_json, headers: {})

    stub_request(:get, boulder_coords_url)
      .to_return(status: 200, body: boulder_coords_json, headers: {})

    stub_request(:get, giphy_url)
      .to_return(status: 200, body: giphy_json, headers: {})
  end

  context "happy path" do
    it "establishes an endpoint to show a specific destination" do
      get api_v1_destination_path(destination_1)

      expect(response).to have_http_status(:ok)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(destination_1.id.to_s)
      expect(result[:data][:type]).to eq("destination")
      expect(result[:data][:attributes][:name]).to eq(destination_1.name)
      expect(result[:data][:attributes][:description]).to eq(destination_1.description)
      expect(result[:data][:attributes][:zip]).to eq(destination_1.zip)
      expect(result[:data][:attributes][:image_url]).to eq(destination_1.image_url)
      expect(result[:data][:attributes][:image_url]).to eq(destination_1.image_url)
      expect(result[:data][:weather][:current_temp]).to eq("39.34")
      expect(result[:data][:weather][:max_temp]).to eq("45.25")
      expect(result[:data][:weather][:min_temp]).to eq("33.21")
      expect(result[:data][:weather][:summary]).to eq("clear sky")
      expect(result[:data][:gif][:gif_url]).to eq("https://media0.giphy.com/media/l1J9IQ6b9EtsW9QFG/giphy.gif?cid=d4cbab6d6hkj1ikrevr83n2xh0hx6gwdb414ttlnld45me57&ep=v1_gifs_search&rid=giphy.gif&ct=g")
    end
  end

  context "sad path" do
    it "returns an error message when subscription wasn't created" do
      get api_v1_destination_path(0)

      expect(response).to have_http_status(:not_found)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)
      expect(parsed).to have_key(:errors)
      expect(parsed[:errors]).to be_an(Array)
      expect(parsed[:errors].first[:status]).to eq("404")
      expect(parsed[:errors].first[:title]).to eq("Couldn't find Destination with 'id'=0")
    end
  end
end
