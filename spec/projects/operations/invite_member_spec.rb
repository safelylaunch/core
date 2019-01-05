# frozen_string_literal: true

RSpec.describe Projects::Operations::InviteMember, type: :operation do
  let(:operation) { described_class.new(project_member_repo: project_member_repo) }
  let(:project_member_repo) { instance_double('ProjectMemberRepository', create: nil) }

  subject { operation.call(account_id: 1, project_id: 2, role: role) }

  context 'when data valid' do
    let(:role) { :admin }

    it { expect(subject).to be_success }
  end

  context 'when role is invalid' do
    let(:role) { :invalid }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:invalid_role) }
  end

  context 'when role is empty' do
    let(:role) { nil }

    it do
      expect(project_member_repo).to receive(:create).with(account_id: 1, project_id: 2, role: 'member')
      expect(subject).to be_success
    end
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:project) { Fabricate.create(:project) }
    let(:account) { Fabricate.create(:account) }

    subject { operation.call(account_id: account.id, project_id: project.id, role: 'admin') }

    it { expect(subject).to be_success }
    it { expect{ subject }.to change { ProjectMemberRepository.new.all.count }.by(1) }
  end
end
