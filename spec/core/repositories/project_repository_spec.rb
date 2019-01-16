# frozen_string_literal: true

RSpec.describe ProjectRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_member' do
    subject { repo.all_for_member(account.id) }

    let(:project) { Fabricate.create(:project) }
    let(:account) { Fabricate.create(:account) }
    let(:environment) { Fabricate.create(:environment, project_id: project.id) }

    context 'when account has some projects' do
      before do
        environment
        Fabricate.create(:project_member, account_id: account.id, project_id: project.id)
      end

      it 'returns list of projects with environments' do
        expect(subject.map(&:id)).to eq([project.id])
        expect(subject.first.environments.map(&:id)).to eq([environment.id])
      end
    end

    context 'when account does not have any projects' do
      it { expect(subject).to eq([]) }
    end
  end

  describe '#create_for_member' do
    subject { repo.create_for_member(account.id, 'test') }

    let(:account) { Fabricate.create(:account) }

    context 'when user can create a project' do
      it { expect(subject).to be_a(Project) }
      it { expect(subject.owner_id).to eq(account.id) }

      it { expect { subject }.to change { repo.root.to_a.count }.by(1) }
      it { expect { subject }.to change { ProjectMemberRepository.new.root.to_a.count }.by(1) }

      it 'setups a user as a admin of the project' do
        project = subject
        project_members = ProjectMemberRepository.new.root.where(account_id: account.id, project_id: project.id)

        expect(project_members.count).to eq(1)
        expect(project_members.first.role).to eq('admin')
      end
    end

    context 'when user has project with same name' do
      before { Fabricate.create(:project, name: 'test', owner_id: account.id) }

      it do
        expect(repo.project_member_repo).to_not receive(:create)
        expect { subject }.to raise_error(Hanami::Model::UniqueConstraintViolationError)
      end
    end
  end

  describe '#remove_member' do
    subject { repo.remove_member(member.id, project.id) }

    let(:project) { Fabricate.create(:project, name: 'test') }
    let(:other_project) { Fabricate.create(:project, name: 'test') }
    let(:project_member_repo) { ProjectMemberRepository.new }

    before { Fabricate.create(:project_member, project_id: project.id) }

    context 'when project contain any members' do
      let(:member) { Fabricate.create(:project_member, project_id: project.id) }

      it 'deletes member from DB' do
        subject
        expect(project_member_repo.find(member.id)).to eq(nil)
      end
    end

    context 'when project does not contain any members' do
      let(:member) { Fabricate.create(:project_member, project_id: other_project.id) }

      it 'does not delete member from DB' do
        subject
        expect(project_member_repo.find(member.id)).to be_a(ProjectMember)
      end
    end
  end

  describe '#find_with_envs' do
    subject { repo.find_with_envs(project_id) }

    let(:project) { Fabricate.create(:project, name: 'test') }

    before { Fabricate.create(:environment, project_id: project.id) }

    context 'when project id exist in db' do
      let(:project_id) { project.id }

      it { expect(subject).to be_a(Project) }
      it { expect(subject.environments.count).to eq(1) }
      it { expect(subject.environments).to all(be_a(Environment)) }
    end

    context 'when project does not contain any members' do
      let(:project_id) { 0 }

      it { expect(subject).to eq(nil) }
    end
  end

  describe '#member?' do
    subject { repo.member?(account_id, project_id) }

    let(:account) { Fabricate.create(:account) }
    let(:project) { Fabricate.create(:project, name: 'test', owner_id: account.id) }

    before { Fabricate.create(:project_member, account_id: account.id, project_id: project.id) }

    context 'when account is member of project' do
      let(:account_id) { account.id }
      let(:project_id) { project.id }

      it { expect(subject).to eq(true) }
    end

    context 'when account is not a member of project' do
      let(:account_id) { 0 }
      let(:project_id) { project.id }

      it { expect(subject).to eq(false) }
    end

    context 'when account is member of the other project' do
      let(:account_id) { account.id }
      let(:project_id) { 0 }

      it { expect(subject).to eq(false) }
    end
  end
end
