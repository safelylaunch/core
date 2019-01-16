# frozen_string_literal: true

RSpec.describe Environments::Operations::Create, type: :operation do
  let(:operation) { described_class.new(env_repo: env_repo, api_key_generator: api_key_generator) }
  let(:api_key_generator) { instance_double('Environments::Libs::ApiKeyGenerator', call: uuid) }
  let(:env_repo) { instance_double('EnvironmentRepository', create: environment) }
  let(:uuid) { SecureRandom.uuid }

  subject { operation.call(project_id: 1, account_id: 1, name: 'stage', color: '000000') }

  context 'when account is a member of project and data is valid' do
    let(:environment) { Environment.new(id: 1) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(Environment.new(id: 1)) }

    it 'calls api key generator' do
      expect(env_repo).to receive(:create).with(project_id: 1, name: 'stage', color: '000000', api_key: uuid)
      subject
    end
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:project) { Fabricate.create(:project) }

    subject { operation.call(project_id: project.id, account_id: 1, name: 'stage', color: '000000') }

    it { expect(subject).to be_success }

    context 'and environment with same api_key exist' do
      let(:operation) { described_class.new(api_key_generator: api_key_generator) }
      let(:api_key_generator) { instance_double('Environments::Libs::ApiKeyGenerator', call: uuid) }
      let(:uuid) { SecureRandom.uuid }

      subject { operation.call(project_id: project.id, account_id: 1, name: 'stage', color: '000000') }

      before { Fabricate.create(:environment, api_key: uuid) }

      it { expect(subject).to be_failure }
    end

    context 'and environment with same name exist in current project' do
      before { Fabricate.create(:environment, project_id: project.id, name: 'stage') }

      it { expect(subject).to be_failure }
    end

    context 'and environment with same name exist in other project' do
      before { Fabricate.create(:environment, name: 'stage') }

      it { expect(subject).to be_success }
    end
  end
end
