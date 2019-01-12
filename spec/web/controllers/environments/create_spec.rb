RSpec.describe Web::Controllers::Environments::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, environment: { project_id: 123, name: 'stage', color: '000000' } } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns a project' do
    let(:operation) { ->(*) { Success(Environment.new(id: 123)) } }

    it { expect(subject).to redirect_to('/projects/123') }

    it 'calls operation with right attributes' do
      allow(operation).to receive(:call).with(
        account_id: 1, account_id: 1, color: '000000', name: 'stage', project_id: 123
      )
      subject
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something) } }

    it { expect(subject).to redirect_to('/projects/123') }
  end

  xcontext 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:params) { { 'rack.session' => session, environment: { project_id: project.id, name: 'stage', color: '000000' } } }

    let(:project) { Fabricate.create(:project) }
    let(:account) { Fabricate.create(:account, id: 1) }

    it { expect(subject).to redirect_to("/projects/#{project.id}") }
  end
end
