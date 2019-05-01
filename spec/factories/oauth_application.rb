FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name         { 'Web' }
    redirect_uri { 'urn:ietf:wg:oauth:2.0:oob' }
    scopes       { 'read write' }
  end
end
