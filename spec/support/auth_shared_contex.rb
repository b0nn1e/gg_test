shared_examples 'check user auth' do
  let(:expected_un_authorize_body) { { error: '401 Unauthorized' }.to_json }

  let(:action) { -> {} }

  context 'when authorization token is not sent' do
    before { action.call }

    it 'returns 401 status' do
      expect(response.status).to eq(401)
    end

    it 'return un-authorize body' do
      expect(response.body).to eq(expected_un_authorize_body)
    end
  end

  context 'when authorization token is blank' do
    before { request.headers['Authorization'] = 'Bearer ' }

    it 'returns 401 status' do
      action.call

      expect(response.status).to eq(401)
    end

    it 'return un-authorize body' do
      action.call

      expect(response.body).to eq(expected_un_authorize_body)
    end
  end

  context 'when authorization token is invalid' do
    let(:token) { Api::BaseController::TOKEN }

    before { request.headers['Authorization'] = "Bearer #{token.reverse}" }

    it 'returns 401 status' do
      action.call

      expect(response.status).to eq(401)
    end

    it 'return un-authorize body' do
      action.call

      expect(response.body).to eq(expected_un_authorize_body)
    end
  end
end
