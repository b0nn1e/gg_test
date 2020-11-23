module Api
  class RecipientsController < BaseController

    def index
      recipients = Recipients::List.call
      render json: RecipientSerializer.render(
        recipients,
        view: :list
      )
    end

    def show
      recipient = Recipients::Item.call(id: params[:id])
      render json: RecipientSerializer.render(
        recipient,
        view: :detailed
      )
    end
  end
end
