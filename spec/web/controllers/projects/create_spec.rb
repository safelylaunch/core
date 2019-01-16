# frozen_string_literal: true

RSpec.describe Web::Controllers::Projects::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, project: { name: 'Test project' } } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns empty list of project' do
    let(:operation) { ->(*) { Success(Project.new(id: 123)) } }

    it { expect(subject).to redirect_to('/') }

    it do
      allow(operation).to receive(:call).with(owner_id: 1, name: 'Test project')
      subject
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something) } }

    it { expect(subject).to redirect_to('/') }
  end

  xcontext 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'whith real dependencies' do
    let(:action) { described_class.new }
    let(:params) { { 'rack.session' => session, project: { name: 'Test project' } } }
    let(:session) { { account: Account.new(id: 1) } }

    before { Fabricate.create(:account, id: 1) }

    it { expect(subject).to redirect_to('/') }
  end
end
