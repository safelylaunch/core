# frozen_string_literal: true

RSpec.describe Projects::Operations::Show, type: :operation do
  let(:operation) { described_class.new(project_repo: project_repo) }
  let(:project_repo) { instance_double('ProjectRepository', member?: is_member, find_with_envs: project) }

  subject { operation.call(account_id: 1, project_id: 2) }

  context 'when a member open exist project' do
    let(:is_member) { true }
    let(:project) { Project.new(id: 1) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Project) }
  end

  context 'when account is not a member of project' do
    let(:is_member) { false }
    let(:project) { Project.new(id: 1) }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:permission_diened) }
  end

  context 'when project does not exist' do
    let(:is_member) { true }
    let(:project) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:not_found) }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:project) { Fabricate.create(:project) }
    let(:account) { Fabricate.create(:account) }

    before { Fabricate.create(:project_member, account_id: account.id, project_id: project.id) }

    subject { operation.call(account_id: account.id, project_id: project.id) }

    it { expect(subject).to be_success }
  end
end
