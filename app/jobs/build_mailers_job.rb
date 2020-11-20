class BuildMailersJob < ApplicationJob
  queue_as :default

  def perform(campaign_id:)
    campaign = Campaign.joins(:recipients).find(campaign_id)
    campaign.recipients.each do |recipient|
      SendMailJob.perform_later(
        email: recipient.email,
        subject: campaign.subject,
        message: campaign.message
      )
    end
  end
end
