# frozen_string_literal: true

RSpec.describe Projects::Operations::Create, type: :operation do
  let(:operation) do
    described_class.new(project_repo: project_repo, env_repo: env_repo)
  end

  let(:project_repo) { instance_double('ProjectRepository', create_for_member: Project.new(id: 123)) }
  let(:env_repo) { instance_double('EnvironmentRepository', create: Environment.new(id: 1)) }
  let(:account) { Account.new(id: 1) }

  subject { operation.call(name: 'test safelylaunch project', owner_id: account.id) }

  context 'when all is okay' do
    it 'returns success monoid with a new project object' do
      expect(subject).to be_success
      expect(subject.value!).to be_a(Project)
    end

    it 'creates a default env for project' do
      expect(env_repo).to receive(:create).with(project_id: 123, name: 'production', color: 'ff0000')
      expect(subject).to be_success
    end
  end

  context 'when user try to create project with dublicated name' do
    before do
      allow(project_repo).to receive(:create_for_member).and_raise(Hanami::Model::UniqueConstraintViolationError)
    end

    it { expect(subject).to be_failure }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:account) { Fabricate.create(:account) }

    it 'returns success monoid with a new project object' do
      expect(subject).to be_success
      expect(subject.value!).to be_a(Project)
    end

    context 'when project with same name exist' do
      before { Fabricate.create(:project, name: 'test safelylaunch project', owner_id: account.id) }

      it { expect(subject).to be_failure }
    end
  end
end
