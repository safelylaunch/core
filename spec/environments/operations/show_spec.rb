# frozen_string_literal: true

RSpec.describe Environments::Operations::Show, type: :operation do
  let(:operation) { described_class.new(env_repo: env_repo) }
  let(:env_repo) { instance_double('EnvironmentRepository', find_with_toggles: environment) }

  subject { operation.call(environment_id: environment_id, account_id: account_id) } 

  let(:environment_id) { 1 }
  let(:account_id) { 1 }

  context 'when account is a member of project and data is valid' do
    xit { expect(subject).to be_success }
  end

  context 'when account is not a member of project' do
    xit { expect(subject).to be_success }
  end
  
  context 'when environment exists' do
    let(:environment) { Environment.new(id: 1) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Environment) }
  end

  context 'when environment does not exist' do
    xit { expect(subject).to be_success }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }

    let(:environment_id) { Fabricate.create(:environment).id }

    it { expect(subject).to be_success }
  end
end
