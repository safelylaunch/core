# frozen_string_literal: true

RSpec.describe Toggles::Operations::ToggleStatus, type: :operation do
  let(:operation) { described_class.new(toggle_repo: toggle_repo) }
  let(:toggle_repo) { instance_double('ToggleRepository', find: toggle, update: toggle) }

  subject { operation.call(id: 1) }

  context 'when toggle does not exist' do
    let(:toggle) { nil }

    it 'returns error object' do
      expect(subject).to be_failure
      expect(subject.failure).to eq(:not_found)
    end
  end

  context 'when toggle exist and enable' do
    let(:toggle) { Toggle.new(status: 'enable') }

    it { expect(subject).to be_success }

    it 'updates toggle with other status' do
      expect(toggle_repo).to receive(:update).with(1, status: 'disable')
      subject
    end
  end

  context 'when toggle exist and disable' do
    let(:toggle) { Toggle.new(status: 'disable') }

    it { expect(subject).to be_success }

    it 'updates toggle with other status' do
      expect(toggle_repo).to receive(:update).with(1, status: 'enable')
      subject
    end
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:toggle) { Fabricate.create(:toggle) }

    subject { operation.call(id: toggle.id) }

    it { expect(subject).to be_success }
  end
end
