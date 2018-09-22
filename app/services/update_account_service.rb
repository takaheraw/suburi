class UpdateAccountService < BaseService
  def call(account, params, raise_error: false)
    was_locked = account.locked
    update_method = raise_error ? :update! : :update
    account.send(update_method, params)
  end
end
