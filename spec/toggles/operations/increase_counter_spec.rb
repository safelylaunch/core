# frozen_string_literal: true

RSpec.describe Toggles::Operations::IncreaseCounter, type: :operation do
  let(:operation) { described_class.new(toggle_counter_repo: toggle_counter_repo) }
  let(:toggle_counter_repo) { instance_double('ToggleCounterRepository', increase_today_counter: 1) }

  subject { operation.call(toggle_id: 1) }

  it { expect(subject).to be_success }

  it 'updates toggle with other status' do
    expect(toggle_counter_repo).to receive(:increase_today_counter).with(1)
    subject
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:toggle) { Fabricate.create(:toggle) }

    subject { operation.call(toggle_id: toggle.id) }

    it { expect(subject).to be_success }
  end
end
