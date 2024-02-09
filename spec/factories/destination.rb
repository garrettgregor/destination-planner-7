FactoryBot.define do
  factory :destination do
    # An array of zip codes representing different locations.
    zips = %w[38016 70115 12203 30014 49418 11731 44133 48348 44646 15068 33801 08302 11432 43123 40165 33756 37013 32068 59901 02474] # rubocop:disable Layout/LineLength

    name { Faker::Address.city }
    zip { zips.sample }
    description { Faker::Lorem.sentence }
    image_url { Faker::Placeholdit.image }
  end
end
