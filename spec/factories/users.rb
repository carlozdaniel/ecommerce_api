# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" } # Genera un correo único para cada usuario
    password { "password" }
  end
end
