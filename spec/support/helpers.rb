def auth_user!
  let(:token) { Auth::TOKEN }
  before { request.headers['Authorization'] = "Bearer #{token}" }
end
