# frozen_string_literal: true

RSpec.describe Toggles::Operations::Check, type: :operation do
  let(:operation) { described_class.new(toggle_repo: toggle_repo) }
  let(:toggle_repo) { instance_double('ToggleRepository', find_by_key_for_env: toggle) }

  subject { operation.call(key: 'test-key', environment_id: 1) }

  context 'when toggle does not exist' do
    let(:toggle) { nil }

    it 'returns error object' do
      expect(subject).to be_failure
      expect(subject.failure).to eq(ErrorObject.new(:not_found, key: 'test-key', environment_id: 1))
    end
  end

  context 'when toggle exist and enable' do
    let(:toggle) { Toggle.new(status: 'enable') }

    it 'returns error object' do
      expect(subject).to be_success
      expect(subject.value!).to eq(key: 'test-key', enable: true)
    end
  end

  context 'when toggle exist and disable' do
    let(:toggle) { Toggle.new(status: 'disable') }

    it 'returns error object' do
      expect(subject).to be_success
      expect(subject.value!).to eq(key: 'test-key', enable: false)
    end
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:toggle) { Fabricate.create(:toggle, environment_id: environment.id) }
    let(:environment) { Fabricate.create(:environment) }

    subject { operation.call(key: toggle.key, environment_id: environment.id) }

    it { expect(subject).to be_success }
  end
end
