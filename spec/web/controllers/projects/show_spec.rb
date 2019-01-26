# frozen_string_literal: true

RSpec.describe Web::Controllers::Projects::Show, type: :action do
  let(:action) { described_class.new(operation: operation, projects_operation: projects_operation) }
  let(:params) { { 'rack.session' => session, id: 123 } }
  let(:session) { { account: Account.new(id: 1) } }
  let(:projects_operation) { ->(*) { Success([Project.new(id: 321)]) } }

  subject { action.call(params) }

  context 'when operation returns a project' do
    let(:operation) { ->(*) { Success(Project.new(id: 123)) } }

    it { expect(subject).to be_success }

    it do
      allow(operation).to receive(:call).with(account_id: 1, project_id: 123)
      subject
    end

    it do
      subject

      expect(action.project).to be_a(Project)

      expect(action.projects.size).to eq(1)
      expect(action.projects).to all(be_a(Project))
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something) } }

    it { expect(subject).to redirect_to('/') }
  end

  context 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:params) { { 'rack.session' => { account: account }, id: project.id } }

    let(:project) { Fabricate.create(:project, id: 1) }
    let(:account) { Fabricate.create(:account, id: 1) }

    before { Fabricate.create(:project_member, account_id: account.id, project_id: project.id) }

    it { expect(subject).to be_success }
  end
end
