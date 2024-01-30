require "rails_helper"

RSpec.describe Destination, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image_url) }

    it { should allow_value("12345").for(:zip) }
    it { should allow_value("12345-1234").for(:zip) }
    it { should_not allow_value("1234").for(:zip) }
    it { should_not allow_value("12345-123").for(:zip) }

    it { should allow_value("http://www.example.com").for(:image_url) }
    it { should allow_value("https://www.example.com").for(:image_url) }
    it { should_not allow_value("www.example.com").for(:image_url) }
    it { should_not allow_value("example.com").for(:image_url) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(100) }
    it { should validate_length_of(:description).is_at_least(1).is_at_most(250) }
  end
end
