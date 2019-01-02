# frozen_string_literal: true

RSpec.describe ToggleRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_by_key_for_env' do
    let(:toggle) { Fabricate.create(:toggle) }
    subject { repo.find_by_key_for_env(key, environment_id) }

    context 'when env contain toggle with specific key' do
      let(:key) { toggle.key }
      let(:environment_id) { toggle.environment_id }

      it { expect(subject).to be_a(Toggle) }
    end

    context 'when env does not contain toggle with specific key' do
      let(:key) { 'other-key' }
      let(:environment_id) { toggle.environment_id }

      it { expect(subject).to eq(nil) }
    end

    context 'when env does not exist' do
      let(:key) { toggle.key }
      let(:environment_id) { 0 }

      it { expect(subject).to eq(nil) }
    end
  end
end
