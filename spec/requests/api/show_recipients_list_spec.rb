require 'rails_helper'

describe 'GET /api/recipients' do
  let(:token) { Auth::TOKEN }
  let(:headers) do
    {
      "Content-Type": "application/json",
      "Authorization": "Bearer #{token}"
    }
  end

  context 'success request' do
    let!(:recipient1) { create(:recipient) }
    let!(:recipient2) { create(:recipient) }
    let!(:recipient3) { create(:recipient) }
    let!(:campaign1) { create(:campaign, recipients: [recipient1, recipient2]) }
    let!(:campaign2) { create(:campaign, recipients: [recipient1, recipient3]) }
    let(:expected_response) do
      {
        recipients: [
          {
            id: recipient1.id,
            email: recipient1.email,
            campaigns_count: 2
          },
          {
            id: recipient2.id,
            email: recipient2.email,
            campaigns_count: 1
          },
          {
            id: recipient3.id,
            email: recipient3.email,
            campaigns_count: 1
          }
        ]
      }.with_indifferent_access
    end

    it do
      get '/api/recipients', params: {}, headers: headers
      json_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_response).to match(expected_response)
    end
  end

  context 'when un-authorized' do
    let(:token) { "invalid token" }
    let(:expected_body) do
      { error: '401 Unauthorized' }.to_json
    end

    it do
      get '/api/recipients', params: {}, headers: headers

      expect(response.status).to eq(401)
      expect(response.body).to eq(expected_body)
    end
  end
end
