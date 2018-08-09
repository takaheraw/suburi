Doorkeeper::Application.create!(name: 'Web', superapp: true, redirect_uri: Doorkeeper.configuration.native_redirect_uri, scopes: 'read write')

if Rails.env.development?
  User.where(email: "admin@localhost").first_or_initialize(email: "admin@localhost", password: 'suburiadmin', password_confirmation: 'suburiadmin', confirmed_at: Time.zone.now, role: :admin).save!
end
