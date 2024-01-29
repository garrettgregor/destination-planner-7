require "rails_helper"

RSpec.describe "Welcome", type: :feature do
  let!(:destination1) { Destination.create(name: "Denver", zip: "80202", description: "Mile High City", image_url: "https://via.placeholder.com/300x300.png")}
  let!(:destination2) { Destination.create(name: "New York", zip: "10001", description: "Big Apple", image_url: "https://via.placeholder.com/300x300.png")}

  before(:each) do
    visit root_path
  end

  describe "welcome page" do
    it "takes me to a page with a list of destinations" do
      expect(page).to have_content("All Destinations")
      expect(page).to have_content("Denver")
      expect(page).to have_content("80202")
      expect(page).to have_content("Mile High City")

      expect(page).to have_content("New York")
      expect(page).to have_content("10001")
      expect(page).to have_content("Big Apple")

      click_link "Show", href: destination_path(destination1)

      expect(current_path).to eq(destination_path(destination1))

      expect(page).to have_content("Denver")
      expect(page).to have_content("80202")
      expect(page).to have_content("Mile High City")

      expect(page).to_not have_content("New York")
      expect(page).to_not have_content("10001")
      expect(page).to_not have_content("Big Apple")
    end
  end
end
