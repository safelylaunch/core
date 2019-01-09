RSpec.describe Web::Controllers::Projects::Members::Index, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, project_id: 123 } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns a project' do
    let(:operation) { ->(*) { Success([ProjectMember.new(id: 123)]) } }

    it { expect(subject).to be_success }

    it do
      allow(operation).to receive(:call).with(account_id: 1, project_id: 123)
      subject
    end

    it do
      subject
      expect(action.members).to all(be_a(ProjectMember))
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
    let(:params) { { 'rack.session' => { account: account }, project_id: project.id } }

    let(:project) { Fabricate.create(:project, id: 1) }
    let(:account) { Fabricate.create(:account, id: 1) }

    before { Fabricate.create(:project_member, account_id: account.id, project_id: project.id) }

    it { expect(subject).to be_success }
  end
end
