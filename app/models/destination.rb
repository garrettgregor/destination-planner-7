class Destination < ApplicationRecord
  validates :name, :zip, :description, :image_url, presence: true
  validates :name, length: {minimum: 1, maximum: 100}, allow_blank: false
  validates :description, length: {minimum: 1, maximum: 250}, allow_blank: false

  validates :zip, format: { with: /\A\d{5}(?:-\d{4})?\z/, message: "should be in the form 12345 or 12345-1234" }
  validates :image_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
