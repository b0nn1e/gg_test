module Recipients
  class List < ApplicationQuery
    def call
      Recipient
        .joins(:campaigns_recipients)
        .select('recipients.*, COUNT(campaigns_recipients.campaign_id) AS campaigns_count')
        .group('recipients.id')
        .order('recipients.created_at ASC')
    end
  end
end
