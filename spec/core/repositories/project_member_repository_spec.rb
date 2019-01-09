# frozen_string_literal: true

RSpec.describe ProjectMemberRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_project' do
    subject { repo.all_for_project(project.id) }

    let(:project) { Fabricate.create(:project) }
    let(:account) { Fabricate.create(:account) }

    context 'when account has some projects' do
      before { Fabricate.create(:project_member, account_id: account.id, project_id: project.id) }

      it 'returns list of projects with environments' do
        expect(subject).to all(be_a(ProjectMember))
        expect(subject.count).to eq(1)
        expect(subject.first.account).to eq(account)
      end
    end

    context 'when account does not have any projects' do
      it { expect(subject).to eq([]) }
    end
  end
end
