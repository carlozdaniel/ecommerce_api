# E-commerce API

Este proyecto es una API RESTful para una aplicación de comercio electrónico, desarrollada con Ruby on Rails. Proporciona funcionalidades para la gestión de usuarios, productos y órdenes, incluyendo autenticación mediante JWT y recomendaciones de productos.

## Tabla de Contenidos

- [Requisitos Previos](#requisitos-previos)
- [Configuración del Entorno](#configuración-del-entorno)
- [Uso de la API](#uso-de-la-api)
- [Comandos de CURL](#comandos-de-curl)
- [Pruebas](#pruebas)
- [Consideraciones](#consideraciones)

## Requisitos Previos

- Ruby 3.2.2
- Rails 7.2.1
- PostgreSQL
- Bundler

## Configuración del Entorno

1. **Clonar el repositorio**

   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd ecommerce_api
   ```

2. **Instalar las dependencias**

   Asegúrate de tener Bundler instalado, luego ejecuta:

   ```bash
   bundle install
   ```

3. **Configurar la base de datos**

   Crea y migra la base de datos:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Configurar las credenciales**

   Edita las credenciales para establecer el secreto JWT:

   ```bash
   EDITOR="code --wait" bin/rails credentials:edit
   ```

   Agrega lo siguiente en las credenciales:

   ```yaml
   devise:
     jwt_secret_key: <genera_un_secreto_seguro>
   ```

   También puedes generar un secreto con:

   ```bash
   rails secret
   ```

5. **Iniciar el servidor**

   ```bash
   rails server
   ```

## Uso de la API

### 1. Crear un Usuario

```bash
curl -X POST http://localhost:3000/api/v1/users \
-H "Content-Type: application/json" \
-d '{
  "user": {
    "email": "testuser@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}'
```

### 2. Iniciar Sesión y Obtener Token JWT

```bash
curl -X POST http://localhost:3000/api/v1/users/sign_in \
-H "Content-Type: application/json" \
-d '{
  "user": {
    "email": "testuser@example.com",
    "password": "password123"
  }
}'
```

### 3. Crear Productos

```bash
curl -X POST http://localhost:3000/api/v1/products \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-d '{
  "product": {
    "name": "Laptop",
    "description": "High-performance laptop",
    "price": 1000.0,
    "stock": 10
  }
}'
```

### 4. Crear Órdenes

```bash
curl -X POST http://localhost:3000/api/v1/orders \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-d '{
  "order": {
    "shipping_address": "123 Main St",
    "order_items_attributes": [
      { "product_id": 1, "quantity": 2 },
      { "product_id": 2, "quantity": 1 }
    ]
  }
}'
```

### 5. Obtener Recomendaciones de Productos Más Vendidos

```bash
curl -X GET http://localhost:3000/api/v1/products/most_sold \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <JWT_TOKEN>"
```

## Comandos de CURL

Aquí están todos los comandos `curl` que puedes usar para interactuar con la API:

1. Crear un usuario:

   ```bash
   curl -X POST http://localhost:3000/api/v1/users \
   -H "Content-Type: application/json" \
   -d '{
     "user": {
       "email": "usuario@example.com",
       "password": "password123",
       "password_confirmation": "password123"
     }
   }'
   ```

2. Iniciar sesión:

   ```bash
   curl -X POST http://localhost:3000/api/v1/users/sign_in \
   -H "Content-Type: application/json" \
   -d '{
     "user": {
       "email": "usuario@example.com",
       "password": "password123"
     }
   }'
   ```

3. Obtener una orden:

   ```bash
   curl -X GET http://localhost:3000/api/v1/orders/1 \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <JWT_TOKEN>"
   ```

4. Eliminar una orden:

   ```bash
   curl -X DELETE http://localhost:3000/api/v1/orders/1 \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <JWT_TOKEN>"
   ```

5. Marcar una orden como pagada:

   ```bash
   curl -X PATCH http://localhost:3000/api/v1/orders/1/mark_as_paid \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <JWT_TOKEN>"
   ```

6. Actualizar un producto:

   ```bash
   curl -X PUT http://localhost:3000/api/v1/products/1 \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <JWT_TOKEN>" \
   -d '{
     "product": {
       "name": "Updated Product",
       "description": "Updated Description",
       "price": 50.0,
       "stock": 15
     }
   }'
   ```

7. Eliminar un producto:

   ```bash
   curl -X DELETE http://localhost:3000/api/v1/products/1 \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <JWT_TOKEN>"
   ```

8. Cerrar sesión:

   ```bash
   curl -X DELETE http://localhost:3000/api/v1/users/sign_out \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <JWT_TOKEN>"
   ```

## Pruebas

Para ejecutar las pruebas, asegúrate de tener las dependencias instaladas y luego ejecuta:

```bash
bundle exec rspec
```

## Consideraciones

- Se utilizó la gema `recombee_api_client` para implementar recomendaciones de productos.
- Las credenciales se han agregado directamente en el proyecto para facilitar la revisión de la prueba, aunque no es una práctica recomendada en un entorno de producción. Esta decisión se tomó con la intención de ser controlada y facilitar la revisión.
- Se podrían agregar más funcionalidades a la API, pero se limitaron las implementaciones por cuestiones de tiempo.

Este README debería proporcionarte una base sólida para entender cómo configurar y usar la API. Si necesitas realizar más configuraciones o agregar funcionalidades, no dudes en hacerlo.

