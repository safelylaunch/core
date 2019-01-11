# frozen_string_literal: true

RSpec.describe Environments::Operations::Create, type: :operation do
  let(:operation) { described_class.new(env_repo: env_repo, api_key_generator: api_key_generator) }
  let(:api_key_generator) { instance_double('Environments::Libs::ApiKeyGenerator', call: uuid) }
  let(:env_repo) { instance_double('EnvironmentRepository') }
  let(:uuid) { SecureRandom.uuid }

  subject { operation.call(token: uuid) } 

  # TODO: specs
  context 'when account is a member of project and data is valid' do
  end

  context 'when account is not a member of project' do
  end
  
  context 'when environment with same name exists' do
  end

  context 'when environment with same uuid exists' do
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }

    before { Fabricate.create(:environment, api_key: uuid) }

    subject { operation.call(token: uuid) }

    xit { expect(subject).to be_success }
  end
end
