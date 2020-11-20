require 'rails_helper'

describe 'POST /api/campaigns', type: :request do
  let(:token) { Auth::TOKEN }
  let(:headers) do
    {
      "Content-Type": "application/json",
      "Authorization": "Bearer #{token}"
    }
  end
  let(:request_body) do
    {
      campaign:
        {
          subject: 'Subject',
          message: 'Message',
          emails: %w[test1@gmail.com test2@gmail.com]
        }
    }.to_json
  end

  context 'success request' do
    it do
      post '/api/campaigns', params: request_body, headers: headers

      expect(response.status).to eq(201)
      expect(response.body).to be_empty
      expect(Campaign.count).to eq(1)
      expect(Recipient.count).to eq(2)
    end
  end


  context 'when un-authorized' do
    let(:token) { "invalid token" }
    let(:expected_body) do
      { error: '401 Unauthorized' }.to_json
    end

    it do
      post '/api/campaigns', params: request_body, headers: headers

      expect(response.status).to eq(401)
      expect(response.body).to eq(expected_body)
      expect(Campaign.count).to eq(0)
      expect(Recipient.count).to eq(0)
    end
  end

  context 'when some validation failed' do
    let(:request_body) do
      {
        campaign:
          {
            subject: '',
            message: 'Message',
            emails: %w[test1@gmail.com test2@gmail.com]
          }
      }.to_json
    end

    let(:expected_body) do
      { errors: { subject: ["can't be blank"] } }.to_json
    end

    it do
      post '/api/campaigns', params: request_body, headers: headers

      expect(response.status).to eq(422)
      expect(response.body).to eq(expected_body)
      expect(Campaign.count).to eq(0)
      expect(Recipient.count).to eq(0)
    end
  end
end
