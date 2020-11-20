def auth_user!
  let(:token) { Api::BaseController::TOKEN }
  before { request.headers['Authorization'] = "Bearer #{token}" }
end
