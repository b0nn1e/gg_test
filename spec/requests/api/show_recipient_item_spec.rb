require 'rails_helper'

describe 'GET /api/recipients/:id' do
  let(:token) { Auth::TOKEN }
  let(:headers) do
    {
      "Content-Type": 'application/json',
      "Authorization": "Bearer #{token}"
    }
  end
  let!(:recipient) { create(:recipient) }
  let!(:campaign) { create_list(:campaign, 3, recipients: [recipient]) }

  context 'success request' do
    let(:expected_response) do
      {
        id: recipient.id,
        email: recipient.email,
        campaigns: [
          {
            id: campaign[0].id,
            subject: campaign[0].subject,
            created_at: campaign[0].created_at.to_s
          },
          {
            id: campaign[1].id,
            subject: campaign[1].subject,
            created_at: campaign[1].created_at.to_s
          },
          {
            id: campaign[2].id,
            subject: campaign[2].subject,
            created_at: campaign[2].created_at.to_s
          }
        ]
      }.with_indifferent_access
    end

    it do
      get "/api/recipients/#{recipient.id}", headers: headers
      json_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_response).to match(expected_response)
    end
  end

  context 'when un-authorized' do
    let(:token) { 'invalid token' }
    let(:expected_body) do
      { error: '401 Unauthorized' }.to_json
    end

    it do
      get "/api/recipients/#{recipient.id}", headers: headers

      expect(response.status).to eq(401)
      expect(response.body).to eq(expected_body)
    end
  end
end
