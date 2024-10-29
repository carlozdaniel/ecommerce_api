# spec/factories/orders.rb
FactoryBot.define do
  factory :order do
    user
    total_price { 0.0 }
    status { "pending" }
    shipping_address { "123 Test Street" }
    payment_status { "unpaid" }

    # Eliminamos el bloque `after(:build)` para que `order_items` no se agreguen automáticamente
  end
end
