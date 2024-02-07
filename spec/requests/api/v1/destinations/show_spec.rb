require "rails_helper"

RSpec.describe "GET /destination/:id" do
  let!(:destination_1) { create(:destination) }
  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

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
