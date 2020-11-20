module Api
  class RecipientsController < BaseController
    # TODO: add serializer

    def index
      response = Recipients::List.call.map { |recipient| recipient.slice(:id, :email, :campaigns_count) }
      render json: { recipients: response }
    end

    def show
      recipient = Recipients::Item.call(id: params[:id])
      campaigns = recipient.campaigns.map do |campaign|
        {
          id: campaign.id,
          subject: campaign.subject,
          created_at: campaign.created_at.to_s
        }
      end
      render json: {
        id: recipient.id,
        email: recipient.email,
        campaigns: campaigns
      }
    end
  end
end
