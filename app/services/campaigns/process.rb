module Campaigns
  class Process < ApplicationService
    attr_accessor :campaign_id

    def initialize(campaign_id:)
      super

      self.campaign_id = campaign_id
    end

    def call
      campaign = Campaign.joins(:customers).find(campaign_id)
      campaign.customers.each do |customer|
        SendMailJob.perform_later(
          email: customer.email,
          subject: campaign.subject,
          message: campaign.message
        )
      end
    end
  end
end
