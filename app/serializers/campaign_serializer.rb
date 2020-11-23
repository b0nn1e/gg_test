class CampaignSerializer < Blueprinter::Base
  fields :id, :subject

  field :created_at do |campaign|
    campaign.created_at.to_s
  end
end
