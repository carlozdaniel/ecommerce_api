# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyText" }
    price { "9.99" }
    stock { 10 }
    association :user, factory: :user # Asociamos un usuario único usando la fábrica `user`
  end
end
