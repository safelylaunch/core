RSpec.describe Web::Controllers::Environments::Show, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, id: 123 } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns a project' do
    let(:operation) { ->(*) { Success(Environment.new(id: 123)) } }

    it { expect(subject).to be_success }

    it do
      allow(operation).to receive(:call).with(account_id: 1, environment_id: 123)
      subject
    end

    it do
      subject
      expect(action.environment).to be_a(Environment)
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

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:params) { { 'rack.session' => { account: account }, id: environment.id } }

    let(:environment) { Fabricate.create(:environment) }
    let(:account) { Fabricate.create(:account, id: 1) }

    it { expect(subject).to be_success }
  end
end
