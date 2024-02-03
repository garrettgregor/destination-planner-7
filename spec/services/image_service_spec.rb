require "rails_helper"

RSpec.describe ImageService do
  describe "#get_image_data" do
    let(:service) { ImageService.new }

    it "parses a json response with a given query", :vcr do
      query = "clear sky"
      result = service.get_image_data(query)

      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data][0]).to be_a(Hash)
      expect(result[:data][0]).to have_key(:images)
      expect(result[:data][0][:images]).to have_key(:original)
      expect(result[:data][0][:images][:original]).to have_key(:url)
      expect(result[:data][0][:images][:original][:url]).to be_a(String)
    end
  end
end
