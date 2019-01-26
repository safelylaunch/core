# frozen_string_literal: true

RSpec.describe Web::Controllers::Dashboard::Index, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns empty list of project' do
    let(:operation) { ->(*) { Success([]) } }

    it { expect(subject).to be_success }

    it do
      allow(operation).to receive(:call).with(account_id: 1)
      subject
    end

    it do
      subject
      expect(action.projects).to eq([])
    end
  end

  context 'when operation returns list of project' do
    let(:operation) { ->(*) { Success([Project.new(id: 1)]) } }

    it { expect(subject).to be_success }

    it do
      subject
      expect(action.projects).to eq([Project.new(id: 1)])
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something) } }

    it { expect(subject).to be_success }
  end

  context 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }

    it { expect(subject).to be_success }
  end
end
