# frozen_string_literal: true

RSpec.describe Toggles::Operations::Delete, type: :operation do
  let(:operation) { described_class.new(toggle_repo: toggle_repo) }
  let(:toggle_repo) { instance_double('ToggleRepository', delete: 1) }

  subject { operation.call(id: 1) }

  it { expect(subject).to be_success }

  it 'updates toggle with other status' do
    expect(toggle_repo).to receive(:delete).with(1)
    subject
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:toggle) { Fabricate.create(:toggle) }

    subject { operation.call(id: toggle.id) }

    it { expect(subject).to be_success }
  end
end
