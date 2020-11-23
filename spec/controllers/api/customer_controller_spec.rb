require 'rails_helper'

describe Api::CustomersController, type: :controller do
  describe 'GET #index' do
    context 'check auth' do
      it_behaves_like 'check user auth' do
        let(:action) { -> { get :index } }
      end
    end

    context 'run query' do
      auth_user!

      let(:klass) { Customers::List }

      before do
        allow(klass).to receive(:call).and_return([])
        get :index
      end

      it 'service called' do
        expect(klass).to have_received(:call)
      end
    end
  end

  describe 'GET #show' do
    context 'check auth' do
      it_behaves_like 'check user auth' do
        let(:action) { -> { get :show, params: { id: 1 } } }
      end
    end

    context 'run query' do
      auth_user!

      let(:klass) { ::Customers::Item }
      let(:customer) { create(:customer) }

      before do
        allow(klass).to receive(:call).and_return(customer)
        get :show, params: { id: 1 }
      end

      it 'service called' do
        expect(klass).to have_received(:call)
      end
    end
  end
end
