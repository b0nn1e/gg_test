require 'rails_helper'

describe RecipientManager::Creator do
  let(:email) { 'validemail@gmail.com' }
  let(:params) { { email: email } }

  context 'valid email' do
    subject!(:result) { described_class.call(params) }

    it { expect(result.success?).to be_truthy }
    it { expect(result.response.class).to be(Recipient) }
    it { expect(result.response.persisted?).to be_truthy }
    it { expect(result.errors.full_messages).to eq([]) }
    it { expect(Recipient.count).to eq(1) }
  end

  context 'when email already exists' do
    subject!(:result) { described_class.call(params) }

    let!(:existing_recipient) { create(:recipient) }
    let(:email) { existing_recipient.email }

    it { expect(result.success?).to be_truthy }
    it { expect(Recipient.count).to eq(1) }
    it { expect(result.response).to eq(existing_recipient) }
  end

  context 'when email invalid' do
    subject!(:result) { described_class.call(params) }

    let(:email) { 'invalid_email' }
    let(:expected_errors) { ['Email is invalid'] }

    it { expect(result.success?).to be_falsey }
    it { expect(Recipient.count).to eq(0) }
    it { expect(result.response).to be_nil }
    it { expect(result.errors.full_messages).to eq(expected_errors) }
  end

  context 'when email is blank' do
    subject!(:result) { described_class.call(params) }

    let(:email) { ' ' }
    let(:expected_errors) { ["Email can't be blank", "Email is invalid"] }

    it { expect(result.success?).to be_falsey }
    it { expect(Recipient.count).to eq(0) }
    it { expect(result.response).to be_nil }
    it { expect(result.errors.full_messages).to eq(expected_errors) }
  end
end
