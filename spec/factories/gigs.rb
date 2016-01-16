FactoryGirl.define do
  factory :gig do
    date      { Faker::Date.between(Date.new(2010,7,10), 1.year.from_now) }
    name      { proper_length_name }
    note      { "#{Faker::Lorem.words(3)} #{Faker::Internet.url} #{Faker::Lorem.words(2)}" }
    location  { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    published false
  end

  factory :picture do
    date      { Faker::Date.between(Date.new(2010,7,10), 1.year.from_now) }
    name      { "[picture]" }
    note      { "#{Faker::Internet.url}/image.png" }
    published false
  end
end

# ensures that faked dates are in a specified range
def between(range)
  (range.min + range.max) / 2
end

# ensures that faked names are not invalid due to length
def proper_length_name
  name = ""
  name = Faker::Name.name until name.length > 13
  name
end
