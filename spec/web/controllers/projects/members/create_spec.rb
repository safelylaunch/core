RSpec.describe Web::Controllers::Projects::Members::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, project_id: 123, member: { email: 'anton@test.com', role: 'member' } } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns a project' do
    let(:operation) { ->(*) { Success(:something) } }

    it { expect(subject).to redirect_to('/projects/123/members') }

    it do
      allow(operation).to receive(:call).with(email: 'anton@test.com', role: 'member', project_id: 123)
      subject
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something) } }

    it { expect(subject).to redirect_to('/projects/123/members') }
  end

  xcontext 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:params) do
      {
        'rack.session' => { account: account },
        project_id: project.id,
        member: { email: account.email, role: 'member' }
      }
    end

    let(:project) { Fabricate.create(:project, id: 1) }
    let(:account) { Fabricate.create(:account, id: 1) }

    it { expect(subject).to redirect_to('/projects/1/members') }
  end
end
