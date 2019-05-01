FactoryBot.define do
  factory :oauth_access_token, class: 'Doorkeeper::AccessToken' do
    expires_in { nil }
    revoked_at { nil }
  end
end
