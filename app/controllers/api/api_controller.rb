# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    include Auth

    before_action :authorize_user!
  end
end
