class Account < ApplicationRecord

  has_one :user, inverse_of: :account

#  validates :username, presence: true
#  validates :username, format: { with: /\A[a-z0-9_]+\z/i }, length: { maximum: 30 }, if: -> { local? && will_save_change_to_username? }
#  validates_with UniqueUsernameValidator, if: -> { local? && will_save_change_to_username? }
#  validates_with UnreservedUsernameValidator, if: -> { local? && will_save_change_to_username? }
#  validates :display_name, length: { maximum: 30 }, if: -> { local? && will_save_change_to_display_name? }
#  validates :note, length: { maximum: 160 }, if: -> { local? && will_save_change_to_note? }

  scope :silenced, -> { where(silenced: true) }
  scope :suspended, -> { where(suspended: true) }
  scope :without_suspended, -> { where(suspended: false) }
  scope :recent, -> { reorder(id: :desc) }
  scope :matches_username, ->(value) { where(arel_table[:username].matches("#{value}%")) }
  scope :matches_display_name, ->(value) { where(arel_table[:display_name].matches("#{value}%")) }
  scope :searchable, -> { where(suspended: false).where(moved_to_account_id: nil) }

  delegate :email,
           :unconfirmed_email,
           :current_sign_in_ip,
           :current_sign_in_at,
           :confirmed?,
           :admin?,
           :locale,
           to: :user,
           prefix: true,
           allow_nil: true

  def suspend!
    transaction do
      user&.disable!
      update!(suspended: true)
    end
  end

  def unsuspend!
    transaction do
      update!(suspended: false)
    end
  end

end
