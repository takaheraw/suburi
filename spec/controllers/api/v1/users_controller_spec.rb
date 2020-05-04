require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  render_views

  let!(:app)    { create(:oauth_application, name: 'Test app') }
  let!(:scopes) { 'read write' }
  let!(:token)  { create(:oauth_access_token, resource_owner_id: nil, application: app, scopes: scopes) }

  describe 'GET #show' do
    let(:schema_path)   { '/users/{id}' }
    let(:schema_method) { 'get' }
    let(:code)          { 200 }
    let!(:user)         { create(:user) }

    context 'without token' do
      it 'returns http unauthorized' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'with token' do
      before do
        allow(controller).to receive(:doorkeeper_token) { token }
        get :show, params: { id: user.id }
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
#        expect_to_conform_schema response
      end
    end
  end

end
