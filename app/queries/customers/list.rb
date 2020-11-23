module Customers
  class List < ApplicationQuery
    def call
      Customer
        .joins(:campaigns_customers)
        .select('customers.*, COUNT(campaigns_customers.campaign_id) AS campaigns_count')
        .group('customers.id')
        .order('customers.created_at ASC')
    end
  end
end
