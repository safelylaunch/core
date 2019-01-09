# frozen_string_literal: true

RSpec.describe Projects::Operations::RemoveMember, type: :operation do
  let(:operation) { described_class.new(project_repo: project_repo) }
  let(:project_repo) { instance_double('ProjectRepository', remove_member: 0) }

  subject { operation.call(member_id: 1, project_id: 2) }

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:project) { Fabricate.create(:project) }

    let(:member) { Fabricate.create(:project_member, project_id: project.id) }

    subject { operation.call(member_id: member.id, project_id: project.id) }

    before { member }

    it { expect(subject).to be_success }
    it { expect{ subject }.to change { ProjectMemberRepository.new.all.count }.by(-1) }
  end
end
