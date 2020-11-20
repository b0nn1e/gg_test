# frozen_string_literal: true

module Api
  class CampaignsController < BaseController

    def create
      result = CampaignManager::Creator.call(permitted_params)

      if result.success?
        head :created
      else
        render json: { errors: result.full_messages }, status: 422
      end
    end

    private

    def permitted_params
      params.require(:campaign).permit(:title, :subject, emails: [])
    end
  end
end
