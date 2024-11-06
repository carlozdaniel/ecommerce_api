# config/initializers/doorkeeper.rb
# frozen_string_literal: true

Doorkeeper.configure do
  # Define el ORM a utilizar por Doorkeeper
  orm :active_record

  # Bloque para verificar si el propietario del recurso está autenticado
  resource_owner_authenticator do
    # Utilizamos Devise para autenticación de usuarios
    current_user || warden.authenticate!(scope: :user)
  end

  # Configuración para la interfaz de administración de Doorkeeper
  # solo accesible a usuarios autenticados
  admin_authenticator do
    current_user || redirect_to(new_user_session_url)
  end

  # Activa el flujo de credenciales de cliente
  grant_flows %w[client_credentials authorization_code]

  # Configura el tiempo de expiración del token de acceso (por ejemplo, 2 horas)
  access_token_expires_in 2.hours

  # Permite tokens sin URI de redirección para flujos como Client Credentials
  allow_blank_redirect_uri do |grant_flows, client|
    grant_flows.include?("client_credentials")
  end

  # Configura Doorkeeper en modo API para API-only, omitiendo vistas
  api_only

  # Define el dominio del header WWW-Authenticate
  realm "Doorkeeper"

  # Configuración de scopes disponibles
  default_scopes :public
  optional_scopes :write, :update

  # Permite reutilizar tokens de acceso para evitar bloat en la base de datos
  # reuse_access_token

  # Asegura que solo el cliente autorizado pueda realizar introspección de tokens
  allow_token_introspection do |token, authorized_client, authorized_token|
    authorized_client == token.application || authorized_token.application == token.application
  end
end
