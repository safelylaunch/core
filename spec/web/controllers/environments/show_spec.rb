# frozen_string_literal: true

RSpec.describe Web::Controllers::Environments::Show, type: :action do
  let(:action) { described_class.new(operation: operation, projects_operation: projects_operation) }
  let(:params) { { 'rack.session' => session, id: 123 } }
  let(:session) { { account: Account.new(id: 1) } }
  let(:projects_operation) { ->(*) { Success([Project.new(id: 321)]) } }

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

      expect(action.projects.size).to eq(1)
      expect(action.projects).to all(be_a(Project))
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

    before { Fabricate.create(:project_member, project_id: environment.project_id, account_id: account.id) }

    it { expect(subject).to be_success }
  end
end
