# spec/factories/doorkeeper.rb

FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name { "Test Application" }
    redirect_uri { "" }
    scopes { "public" }
  end

  factory :access_token, class: 'Doorkeeper::AccessToken' do
    application { create(:oauth_application) }
    resource_owner_id { nil } # Para client_credentials, puede ser nil
    scopes { "public" }
    expires_in { 2.hours }
  end
end
