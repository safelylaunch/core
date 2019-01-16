# frozen_string_literal: true

RSpec.describe Projects::Operations::InviteMember, type: :operation do
  let(:operation) { described_class.new(project_member_repo: project_member_repo, account_repo: account_repo) }
  let(:project_member_repo) { instance_double('ProjectMemberRepository', create: nil) }
  let(:account_repo) { instance_double('AccountRepository', find_by_email: account) }
  let(:account) { Account.new(id: 1) }
  let(:role) { :admin }

  subject { operation.call(email: 'anton@test.com', project_id: 2, role: role) }

  context 'when data valid' do
    it { expect(subject).to be_success }
  end

  context 'when role is invalid' do
    let(:role) { :invalid }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:invalid_role) }
  end

  context 'when account not found in the system' do
    let(:account) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:account_not_found) }
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

    before { Fabricate.create(:account, email: 'anton@test.com') }

    subject { operation.call(email: 'anton@test.com', project_id: project.id, role: 'admin') }

    it { expect(subject).to be_success }
    it { expect { subject }.to change { ProjectMemberRepository.new.all.count }.by(1) }
  end
end
