# frozen_string_literal: true

RSpec.describe Projects::Operations::List, type: :operation do
  let(:operation) { described_class.new(project_repo: project_repo) }
  let(:project_repo) { instance_double('ProjectRepository', all_for_member: projects) }
  let(:account_id) { 1 }

  subject { operation.call(account_id: account_id) }

  context 'when account has projects' do
    let(:projects) { [Project.new(id: 1)] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([Project.new(id: 1)]) }
  end

  context 'when account does not have any projects' do
    let(:projects) { [] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([]) }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:project) { Fabricate.create(:project) }
    let(:account) { Fabricate.create(:account) }
    let(:account_id) { account.id }

    before { Fabricate.create(:project_member, account_id: account.id, project_id: project.id) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.count).to eq(1) }
  end
end
