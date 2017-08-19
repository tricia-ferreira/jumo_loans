require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe 'GET#index' do
    context 'format html' do
      subject { get :index }
      before { subject }

      it 'returns a 200 status' do
        expect(response.status).to eq 200
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    context 'format csv' do
      subject { get :index, format: :csv }

      it 'returns a 200 status' do
        subject
        expect(response.status).to eq 200
      end

      it 'renders to csv' do
        subject
        expect(response.header['Content-Type']).to include 'text/csv'
      end
    end
  end
end
