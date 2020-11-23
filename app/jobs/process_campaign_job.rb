class ProcessCampaignJob < ApplicationJob
  queue_as :default

  def perform(campaign_id:)
    Campaigns::Process.call(campaign_id: campaign_id)
  end
end
