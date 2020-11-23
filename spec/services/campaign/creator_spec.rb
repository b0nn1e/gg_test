require 'rails_helper'

describe Campaigns::Creator do
  let(:emails) { %w[test1@gmail.com test2@gmail.com test3@gmail.com] }
  let(:title) { 'title' }
  let(:message) { 'message' }
  let(:params) do
    {
      emails: emails,
      subject: title,
      message: message
    }
  end

  context 'when valid args' do
    subject!(:result) { described_class.call(params) }

    it { expect(result.success?).to be_truthy }
    it { expect(result.errors.full_messages).to eq([]) }
    it { expect(Customer.count).to eq(3) }
    it { expect(Campaign.count).to eq(1) }
  end

  context 'run job' do
    let(:job_args) { { campaign_id: Campaign.last.id } }

    before do
      allow(ProcessCampaignJob).to receive(:perform_later)
      described_class.call(params)
    end

    it { expect(ProcessCampaignJob).to have_received(:perform_later).with(job_args) }
  end

  context 'when params is empty' do
    subject!(:result) { described_class.call(params) }

    let(:params) { {} }
    let(:expected_errors) do
      ["Subject can't be blank", "Message can't be blank", "Emails can't be blank"]
    end

    it { expect(result.success?).to be_falsey }
    it { expect(Customer.count).to eq(0) }
    it { expect(Campaign.count).to eq(0) }
    it { expect(result.errors.full_messages).to eq(expected_errors) }
  end

  context 'when send only invalid email' do
    subject!(:result) { described_class.call(params) }

    let(:emails) { %w[invalidemail] }
    let(:expected_errors) do
      ["Emails 'invalidemail' is invalid"]
    end

    it { expect(result.success?).to be_falsey }
    it { expect(Customer.count).to eq(0) }
    it { expect(Campaign.count).to eq(0) }
    it { expect(result.errors.full_messages).to eq(expected_errors) }
  end

  context 'when customers is already exists' do
    subject!(:result) { described_class.call(params) }

    let!(:existing_customers) { create_list(:customer, 3) }
    let(:emails) { existing_customers.pluck(:email) }

    it { expect(result.success?).to be_truthy }
    it { expect(Customer.count).to eq(3) }
    it { expect(Campaign.count).to eq(1) }
    it { expect(Customer.all).to eq(existing_customers) }
  end

  context 'when customers is already exists and someone new' do
    context 'when customers is already exists' do
      subject!(:result) { described_class.call(params) }

      let!(:existing_customers) { create_list(:customer, 3) }
      let(:new_customer_email) { 'newrecepient@gmail.com' }
      let(:emails) { existing_customers.pluck(:email) | [new_customer_email] }

      it { expect(result.success?).to be_truthy }
      it { expect(Customer.count).to eq(4) }
      it { expect(Campaign.count).to eq(1) }
      it { expect(Customer.last.email).to eq(new_customer_email) }
    end
  end

  context 'when emails is string' do
    subject!(:result) { described_class.call(params) }
    let(:emails) { 'test1@gmail.com, test2@gmail.com, test3@gmail.com' }

    it { expect(result.success?).to be_truthy }
    it { expect(Customer.count).to eq(3) }
    it { expect(Campaign.count).to eq(1) }
  end
end
