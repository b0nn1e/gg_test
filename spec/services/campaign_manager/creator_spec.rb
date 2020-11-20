require 'rails_helper'

describe CampaignManager::Creator do
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
    it { expect(Recipient.count).to eq(3) }
    it { expect(Campaign.count).to eq(1) }
  end

  context 'when params is empty' do
    subject!(:result) { described_class.call(params) }

    let(:params) { {} }
    let(:expected_errors) do
      ["Subject can't be blank", "Message can't be blank", "Emails can't be blank"]
    end

    it { expect(result.success?).to be_falsey }
    it { expect(Recipient.count).to eq(0) }
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
    it { expect(Recipient.count).to eq(0) }
    it { expect(Campaign.count).to eq(0) }
    it { expect(result.errors.full_messages).to eq(expected_errors) }
  end

  context 'when recipients is already exists' do
    subject!(:result) { described_class.call(params) }

    let!(:existing_recipients) { create_list(:recipient, 3) }
    let(:emails) { existing_recipients.pluck(:email) }

    it { expect(result.success?).to be_truthy }
    it { expect(Recipient.count).to eq(3) }
    it { expect(Campaign.count).to eq(1) }
    it { expect(Recipient.all).to eq(existing_recipients) }
  end

  context 'when recipients is already exists and someone new' do
    context 'when recipients is already exists' do
      subject!(:result) { described_class.call(params) }

      let!(:existing_recipients) { create_list(:recipient, 3) }
      let(:new_recipient_email) { 'newrecepient@gmail.com' }
      let(:emails) { existing_recipients.pluck(:email) | [new_recipient_email] }

      it { expect(result.success?).to be_truthy }
      it { expect(Recipient.count).to eq(4) }
      it { expect(Campaign.count).to eq(1) }
      it { expect(Recipient.last.email).to eq(new_recipient_email) }
    end
  end

  context 'when emails is string' do
    subject!(:result) { described_class.call(params) }
    let(:emails) { 'test1@gmail.com, test2@gmail.com, test3@gmail.com' }

    it { expect(result.success?).to be_truthy }
    it { expect(Recipient.count).to eq(3) }
    it { expect(Campaign.count).to eq(1) }
  end
end
