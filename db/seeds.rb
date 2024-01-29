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
    50.times do |i|
      dest = Destination.create!(
        name: Faker::Address.city,
        zip: Faker::Address.zip,
        description: Faker::Lorem.sentence,
        image_url: Faker::Placeholdit.image
      )
      puts "Destination #{i}: #{dest.name} created!"
    end
  end
end

Seed.start
