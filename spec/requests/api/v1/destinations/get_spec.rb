require "rails_helper"

RSpec.describe "GET /destinations", type: :request do
  let!(:destinations) { create_list(:destination, 3) }
  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  context "happy path" do
    it "establishes an endpoint to get all destinations" do
      get api_v1_destinations_path, headers: valid_headers

      expect(response).to have_http_status(:ok)

      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data].length).to eq(3)

      results[:data].each do |d|
        expect(d).to have_key(:id)
        expect(d[:type]).to eq("destination")
        expect(d[:attributes]).to have_key(:name)
        expect(d[:attributes]).to have_key(:zip)
        expect(d[:attributes]).to have_key(:description)
        expect(d[:attributes]).to have_key(:image_url)
      end
    end
  end
end
