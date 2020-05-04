require 'rails_helper'

RSpec.describe "Api::V1::UsersController", type: :request do
  let!(:scopes)       { 'read write' }
  let!(:access_token) { create(:oauth_access_token, resource_owner_id: nil, application: create(:oauth_application, name: 'Test app'), scopes: scopes) }

  describe 'GET #show' do
    let!(:user)         { create(:user) }

    context 'without token' do
      it 'returns http unauthorized' do
        get "/api/v1/users/#{user.id}"
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'with token' do
      before do
        get "/api/v1/users/#{user.id}", params: {}, headers: { 'Authorization': 'Bearer ' + access_token.token }
      end

      it 'returns http success' do
        expect(response).to have_http_status(200)
      end

      it 'assigns @user' do
        expect(assigns(:user)).to eq(user)
      end

      it "JSON body response contains expected user attributes" do
        expect(body_as_json.keys).to match_array [ :id, :email, :role ]
      end

      it 'conform json schema' do
        assert_response_schema_confirm
      end
    end
  end
end
