require "rails_helper"

RSpec.describe ImageFacade do
  describe "#image_of" do
    let(:facade) { ImageFacade.new }

    it "returns a new giphy image with url" do
      giphy_json = File.read("spec/fixtures/clear_sky_giphy.json")
      giphy_url = "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=clear sky&limit=1&offset=0&rating=g&lang=en&bundle=messaging_non_clips" # rubocop:disable Layout/LineLength

      stub_request(:get, giphy_url)
        .to_return(status: 200, body: giphy_json, headers: {})

      query = "clear sky"
      image = facade.image_of(query)

      expect(image).to be_a(Giphy)
      expect(image.url).to eq("https://media0.giphy.com/media/l1J9IQ6b9EtsW9QFG/giphy.gif?cid=d4cbab6d6hkj1ikrevr83n2xh0hx6gwdb414ttlnld45me57&ep=v1_gifs_search&rid=giphy.gif&ct=g")
    end
  end
end
