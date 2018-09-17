# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string(255)      default(""), not null
#  account_id             :bigint(8)        not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default(NULL), not null
#

class User < ApplicationRecord
  ACTIVE_DURATION = ENV.fetch('USER_ACTIVE_DAYS', 7).to_i.days

  enum role: { admin: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  belongs_to :account, inverse_of: :user

  has_many :oauth_access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id

  scope :recent, -> { order(id: :desc) }
  scope :inactive, -> { where(arel_table[:current_sign_in_at].lt(ACTIVE_DURATION.ago)) }
  scope :active, -> { confirmed.where(arel_table[:current_sign_in_at].gteq(ACTIVE_DURATION.ago)).joins(:account).where(accounts: { suspended: false }) }
  scope :matches_email, ->(value) { where(arel_table[:email].matches("#{value}%")) }
  scope :with_recent_ip_address, ->(value) { where(arel_table[:current_sign_in_ip].eq(value).or(arel_table[:last_sign_in_ip].eq(value))) }

  def confirmed?
    confirmed_at.present?
  end

  def disable!
    update!(
      last_sign_in_at: current_sign_in_at,
      current_sign_in_at: nil
    )
  end

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
