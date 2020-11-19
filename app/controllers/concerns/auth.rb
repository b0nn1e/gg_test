# frozen_string_literal: true

module Auth
  TOKEN = '8d4aa039dde3f9cf90dc68e0d32b6f90'

  private

  def authorize_user!
    render json: { error: '401 Unauthorized' }, status: 401 unless user_authorized?
  end

  def user_authorized?
    TOKEN == token
  end

  def token
    @token ||= auth_header.split(' ')[1]
  end

  def auth_header
    request.headers['Authorization'] || ''
  end
end
