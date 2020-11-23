require 'rails_helper'

describe 'GET /api/customers' do
  let(:token) { Auth::TOKEN }
  let(:headers) do
    {
      "Content-Type": "application/json",
      "Authorization": "Bearer #{token}"
    }
  end

  context 'success request' do
    let!(:customer1) { create(:customer) }
    let!(:customer2) { create(:customer) }
    let!(:customer3) { create(:customer) }
    let!(:campaign1) { create(:campaign, customers: [customer1, customer2]) }
    let!(:campaign2) { create(:campaign, customers: [customer1, customer3]) }
    let(:expected_response) do
      [
        {
          id: customer1.id,
          email: customer1.email,
          campaigns_count: 2
        },
        {
          id: customer2.id,
          email: customer2.email,
          campaigns_count: 1
        },
        {
          id: customer3.id,
          email: customer3.email,
          campaigns_count: 1
        }
      ].to_json
    end

    it do
      get '/api/customers', params: {}, headers: headers

      expect(response.status).to eq(200)
      expect(response.body).to match(expected_response)
    end
  end

  context 'when un-authorized' do
    let(:token) { "invalid token" }
    let(:expected_body) do
      { error: '401 Unauthorized' }.to_json
    end

    it do
      get '/api/customers', params: {}, headers: headers

      expect(response.status).to eq(401)
      expect(response.body).to eq(expected_body)
    end
  end
end
