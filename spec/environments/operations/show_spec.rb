# frozen_string_literal: true

RSpec.describe Environments::Operations::Show, type: :operation do
  let(:operation) { described_class.new(env_repo: env_repo) }
  let(:env_repo) { instance_double('EnvironmentRepository', find_with_toggles: environment) }

  subject { operation.call(environment_id: environment_id, account_id: account_id) }

  let(:environment_id) { 1 }
  let(:account_id) { 1 }

  context 'when environment exists' do
    let(:environment) { Environment.new(id: 1) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Environment) }
  end

  context 'when environment does not exist' do
    let(:environment) { nil }

    it { expect(subject).to be_failure }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }

    let(:environment_id) { Fabricate.create(:environment).id }

    it { expect(subject).to be_success }
  end
end
