require "rails_helper"

RSpec.describe "DELETE /destinations/:id", type: :request do
  let!(:destination1) { create(:destination) }
  let!(:destination2) { create(:destination) }
  let!(:destination3) { create(:destination) }
  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  context "happy path" do
    it "establishes an endpoint to destroy a destination" do
      delete api_v1_destination_path(destination3), headers: valid_headers

      expect(response).to have_http_status(:ok)

      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data].length).to eq(2)

      results[:data].each do |d|
        expect(d).to have_key(:id)
        expect(d[:id]).to_not eq("3")
        expect(d[:type]).to eq("destination")
        expect(d[:attributes]).to have_key(:name)
        expect(d[:attributes]).to have_key(:zip)
        expect(d[:attributes]).to have_key(:description)
        expect(d[:attributes]).to have_key(:image_url)
      end
    end
  end

  context "sad path" do
    it "establishes an endpoint to handle not found errors when destroying a destination" do
      delete api_v1_destination_path(0), headers: valid_headers

      expect(response).to have_http_status(:not_found)

      results = JSON.parse(response.body, symbolize_names: true)

      expect(results[:errors][0][:status]).to eq("404")
      expect(results[:errors][0][:title]).to eq("Couldn't find Destination with 'id'=0")
    end
  end
end
