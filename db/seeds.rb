# Limpieza de datos para evitar duplicados
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all

# Creación de usuarios
user1 = User.create!(
  email: "user1@example.com",
  password: "password123",
  password_confirmation: "password123"
)

user2 = User.create!(
  email: "user2@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "Usuarios creados: #{User.count}"

# Creación de productos
product1 = Product.create!(
  name: "Producto 1",
  description: "Descripción del Producto 1",
  price: 25.99,
  stock: 10
)

product2 = Product.create!(
  name: "Producto 2",
  description: "Descripción del Producto 2",
  price: 15.50,
  stock: 20
)

product3 = Product.create!(
  name: "Producto 3",
  description: "Descripción del Producto 3",
  price: 10.75,
  stock: 15
)

puts "Productos creados: #{Product.count}"
