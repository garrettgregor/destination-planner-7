# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

class Seed
  def self.start
    seed = Seed.new
    seed.generate_destinations
  end

  def generate_destinations
    # random list of valid zips until faker data is fixed
    zips = %w[38016 70115 12203 30014 49418 11731 44133 48348 44646 15068 33801 08302 11432 43123 40165 33756 37013 32068 59901 02474]

    50.times do |i|
      dest = Destination.create!(
        name: Faker::Address.city,
        zip: zips.sample,
        description: Faker::Lorem.sentence,
        image_url: Faker::Placeholdit.image
      )
      Rails.logger.debug "Destination #{i}: #{dest.name} created!"
    end
  end
end

Seed.start
