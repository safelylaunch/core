# frozen_string_literal: true

RSpec.describe Environments::Operations::Authorizer, type: :operation do
  let(:uuid) { SecureRandom.uuid }
  let(:operation) { described_class.new(env_repo: env_repo) }
  let(:env_repo) { instance_double('EnvironmentRepository', find_for_token: environment) }

  subject { operation.call(token: uuid) }

  context 'when token correct' do
    let(:environment) { Environment.new(id: 1) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(environment_id: 1) }
  end

  context 'when token incorrect' do
    let(:environment) { nil }

    it { expect(subject).to be_failure }

    it 'returns error object' do
      expect(subject).to be_failure
      expect(subject.failure).to eq(ErrorObject.new(:auth_failure, token: uuid))
    end
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }

    before { Fabricate.create(:environment, api_key: uuid) }

    subject { operation.call(token: uuid) }

    it { expect(subject).to be_success }
  end
end
