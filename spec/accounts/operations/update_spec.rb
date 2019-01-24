# frozen_string_literal: true

RSpec.describe Accounts::Operations::Update, type: :operation do
  let(:operation) { described_class.new(account_repo: account_repo) }
  let(:account_repo) { instance_double('AccountRepository', update: Account.new) }

  subject { operation.call(account_id: account_id, payload: payload) }

  let(:account_id) { 1 }
  let(:payload) { {} }

  context 'when account exist' do
    let(:account_id) { 1 }

    xcontext 'and payload is valid' do
      let(:payload) { {} }
    end

    xcontext 'and payload is invalid' do
      let(:payload) { {} }
    end
  end

  context 'when account does not exist' do
    let(:account_id) { 0 }

    it { expect(subject).to be_success }
  end

  context 'when account is invalid' do
    let(:account_id) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq :invalid_account }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:account) { Fabricate.create(:account) }

    subject { operation.call(account_id: account.id, payload: { name: 'other name' }) }

    it { expect(subject).to be_success }
  end
end
