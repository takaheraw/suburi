class User < ApplicationRecord
  ACTIVE_DURATION = ENV.fetch('USER_ACTIVE_DAYS', 7).to_i.days

  enum role: { admin: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :oauth_access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id

  scope :recent, -> { order(id: :desc) }
  scope :inactive, -> { where(arel_table[:current_sign_in_at].lt(ACTIVE_DURATION.ago)) }
  scope :active, -> { confirmed.where(arel_table[:current_sign_in_at].gteq(ACTIVE_DURATION.ago)).joins(:account).where(accounts: { suspended: false }) }
  scope :matches_email, ->(value) { where(arel_table[:email].matches("#{value}%")) }
  scope :with_recent_ip_address, ->(value) { where(arel_table[:current_sign_in_ip].eq(value).or(arel_table[:last_sign_in_ip].eq(value))) }

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
