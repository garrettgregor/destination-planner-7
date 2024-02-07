require "rails_helper"

RSpec.describe "PATCH /destinations" do
  let!(:destination_1) { create(:destination) }
  let!(:valid_patch_info) do
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

  let!(:incorrect_strong_params_patch) do
    {
      destinations:
      {
        zip: "90211"
      }
    }
  end

  let!(:invalid_attributes_patch) do
    {
      destination:
        {
          zips: "91786",
          wrong_item: "wrong_string"
        }
    }
  end

  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  context "happy path" do
    it "establishes an endpoint to update a destination" do
      patch api_v1_destination_path(destination_1), params: valid_patch_info.to_json, headers: valid_headers

      expect(response).to have_http_status(:accepted)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data][:id]).to eq(destination_1.id.to_s)
      expect(result[:data][:type]).to eq("destination")
      expect(result[:data][:attributes][:name]).to eq(valid_patch_info[:destination][:name])
      expect(result[:data][:attributes][:description]).to eq(valid_patch_info[:destination][:description])
      expect(result[:data][:attributes][:zip]).to eq(valid_patch_info[:destination][:zip])
      expect(result[:data][:attributes][:image_url]).to eq(valid_patch_info[:destination][:image_url])
    end
  end

  context "sad path" do
    it "returns an error message when not providing a destination" do
      patch api_v1_destination_path(destination_1), params: incorrect_strong_params_patch.to_json,
                                                    headers: valid_headers

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
      patch api_v1_destination_path(destination_1), params: invalid_attributes_patch.to_json,
                                                    headers: valid_headers

      expect(response).to have_http_status(:not_acceptable)

      expected_response = { errors: [{ status: "406", title: "found unpermitted parameters: :zips, :wrong_item" }] }

      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
