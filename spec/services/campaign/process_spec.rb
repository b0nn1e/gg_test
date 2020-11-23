require 'rails_helper'

describe Campaigns::Process do
  let(:campaign) { create(:campaign, customers: [customer1, customer2]) }
  let(:customer1) { create(:customer) }
  let(:customer2) { create(:customer) }
  let(:args1) do
    {
      email: customer1.email,
      subject: campaign.subject,
      message: campaign.message
    }
  end
  let(:args2) do
    {
      email: customer2.email,
      subject: campaign.subject,
      message: campaign.message
    }
  end

  before do
    allow(SendMailJob).to receive(:perform_later)
    described_class.call(campaign_id: campaign.id)
  end

  it { expect(SendMailJob).to have_received(:perform_later).with(args1) }
  it { expect(SendMailJob).to have_received(:perform_later).with(args2) }
  it { expect(SendMailJob).to have_received(:perform_later).twice }
end
