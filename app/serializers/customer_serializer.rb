class CustomerSerializer < Blueprinter::Base
  fields :id, :email

  view :list do
    fields :id, :email, :campaigns_count
  end

  view :detailed do
    fields :id, :email
    association :campaigns_ordered, name: :campaigns, blueprint: CampaignSerializer
  end
end
