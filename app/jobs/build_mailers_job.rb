class BuildMailersJob < ApplicationJob
  queue_as :default

  def perform(campaign_id:)
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
