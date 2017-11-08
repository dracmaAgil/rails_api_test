FactoryBot.define do
  factory :task do
    user
    description { Faker::Lorem.paragraph }
    website '<html><head><title><h1>foo trek</h1><h2>bar</h2></title><body><p>bar</p></body></html>'
    header ''
    status 'finished'
    expiration_date { DateTime.now }
  end
end
