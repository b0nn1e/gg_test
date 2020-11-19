require 'rails_helper'

describe Api::CampaignsController, type: :controller do
  describe 'POST #create' do
    it_behaves_like 'check user auth' do
      let(:action) { -> { post :create } }
    end
  end
end
