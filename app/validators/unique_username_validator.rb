class UniqueUsernameValidator < ActiveModel::Validator

  def validate(account)
    return if account.username.nil?

    normalized_username = account.username.downcase.delete('.')

    scope = Account.where('lower(username) = ?', normalized_username)
    scope = scope.where.not(id: account.id) if account.persisted?

    account.errors.add(:username, :taken) if scope.exists?
  end

end
