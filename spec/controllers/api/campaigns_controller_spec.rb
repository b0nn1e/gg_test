require 'rails_helper'

describe Api::CampaignsController, type: :controller do
  describe 'POST #create' do
    let(:params) do
      {
        subject: 'Subject',
        messages: 'Message',
        emails: %w[test1@gmail.com test2@gmail.com]
      }
    end
    context 'check auth' do
      it_behaves_like 'check user auth' do
        let(:action) { -> { post :create, params: { campaign: params } } }
      end
    end

    context 'run service' do
      auth_user!

      it_behaves_like 'run service' do
        let(:klass) { CampaignManager::Creator }
        let(:action) { -> { post :create, params: { campaign: params } } }
      end
    end
  end
end
