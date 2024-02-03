require "rails_helper"

RSpec.describe Giphy do
  let(:giphy_json) { File.read("spec/fixtures/clear_sky_giphy.json") }
  let(:giphy) { Giphy.new(JSON.parse(giphy_json, symbolize_names: true)) }

  describe "initialize" do
    it "creates a giphy with a url" do
      url = "https://media0.giphy.com/media/l1J9IQ6b9EtsW9QFG/giphy.gif?cid=d4cbab6d6hkj1ikrevr83n2xh0hx6gwdb414ttlnld45me57&ep=v1_gifs_search&rid=giphy.gif&ct=g"

      expect(giphy).to be_a(Giphy)
      expect(giphy.url).to eq(url)
    end
  end
end
