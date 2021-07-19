require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe 'GET #index' do
    subject { get :index }

    context 'when not signed in' do
      it 'renders index page' do
        expect(subject).to render_template :index
      end
    end
  end
end
