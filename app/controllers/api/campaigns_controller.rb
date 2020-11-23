# frozen_string_literal: true

module Api
  class CampaignsController < BaseController

    def create
      result = Campaigns::Creator.call(permitted_params.to_h)

      if result.success?
        head :created
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:campaign).permit(:subject, :message, emails: [])
    end
  end
end
