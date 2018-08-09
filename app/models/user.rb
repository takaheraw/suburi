class User < ApplicationRecord
  enum role: { admin: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :oauth_access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id

  def activate_access_token(request)
    superapp = Doorkeeper::Application.find_by(superapp: true)
    return if superapp.blank?

    return if Doorkeeper::AccessToken.exists?(application_id: superapp.id, resource_owner_id: self.id)

    Doorkeeper::AccessToken.create!(
      application_id:    superapp&.id,
      resource_owner_id: self.id,
      expires_in:        Doorkeeper.configuration.access_token_expires_in,
      use_refresh_token: Doorkeeper.configuration.refresh_token_enabled?)
  end
end
