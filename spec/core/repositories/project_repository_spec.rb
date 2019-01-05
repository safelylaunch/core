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
end
