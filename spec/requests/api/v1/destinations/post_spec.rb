require "rails_helper"

RSpec.describe "POST /destinations" do
  let!(:valid_post_info) do
    {
      destination:
        {
          name: "New Name",
          description: "New Description",
          zip: "90210",
          image_url: "http://www.fakeurl.com"
        }
    }
  end

  let!(:invalid_post_info_strong_params) do
    {
      destinations:
        {
          name: "New Name",
          description: "New Description",
          zip: "90210",
          image_url: "http://www.fakeurl.com"
        }
    }
  end

  let!(:invalid_post_info_missing_zip) do
    {
      destination:
        {
          name: "New Name",
          description: "New Description",
          image_url: "http://www.fakeurl.com"
        }
    }
  end

  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  context "happy path" do
    it "establishes an endpoint to update a destination" do
      post api_v1_destinations_path, params: valid_post_info.to_json, headers: valid_headers

      expect(response).to have_http_status(:created)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data][:id]).to eq("1")
      expect(result[:data][:type]).to eq("destination")
      expect(result[:data][:attributes][:name]).to eq(valid_post_info[:destination][:name])
      expect(result[:data][:attributes][:description]).to eq(valid_post_info[:destination][:description])
      expect(result[:data][:attributes][:zip]).to eq(valid_post_info[:destination][:zip])
      expect(result[:data][:attributes][:image_url]).to eq(valid_post_info[:destination][:image_url])
    end
  end

  context "sad paths" do
    it "returns an error message when not providing a destination" do
      post api_v1_destinations_path, params: invalid_post_info_strong_params.to_json, headers: valid_headers

      expect(response).to have_http_status(:not_acceptable)

      expected_response = {
        error: "You must update a destination using one of the following formats",
        acceptable_formats: [
          { destination: { valid_attribute: "new_attributes" } },
          { valid_attribute: "new_attributes" }
        ]
      }

      expect(response.body).to eq(expected_response.to_json)
    end

    it "returns an error message when not providing a destination" do
      post api_v1_destinations_path, params: invalid_post_info_missing_zip.to_json, headers: valid_headers

      expect(response).to have_http_status(:not_acceptable)

      expected_response = { errors: [{ status: "406", title: "Zip can't be blank" },
                                     { status: "406", title: "Zip should be in the form 12345 or 12345-1234" }] }

      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
