FactoryBot.define do
  factory :task do
    user
    description { Faker::Lorem.paragraph }
    website 'www.MyString.com'
    header '<h1> hola </h1>'
    status 'finished'
    expiration_date { DateTime.now }
  end
end
