module Api
  class CustomersController < BaseController

    def index
      customers = Customers::List.call
      render json: CustomerSerializer.render(
        customers,
        view: :list
      )
    end

    def show
      customer = Customers::Item.call(id: params[:id])
      render json: CustomerSerializer.render(
        customer,
        view: :detailed
      )
    end
  end
end
