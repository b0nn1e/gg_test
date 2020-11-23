class BuildMailersJob < ApplicationJob
  queue_as :default

  def perform(campaign_id:)
    Campaigns::Sender.call(campaign_id: campaign_id)
  end
end
