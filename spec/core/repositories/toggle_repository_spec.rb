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

  describe '#all_for' do
    let(:environment) { Fabricate.create(:environment) }

    subject { repo.all_for(environment.id) }

    context 'when environment contain toggles' do
      before do
        Fabricate.create(:toggle, environment_id: environment.id, key: 'test1')
        Fabricate.create(:toggle, environment_id: environment.id, key: 'test2')
      end

      it 'returns list of environment toggles' do
        expect(subject.count).to eq 2
        expect(subject).to all(be_a(Toggle))
      end
    end

    context 'when environment does not contain any toggles' do
      it { expect(subject).to eq([]) }
    end

    context 'when method take other type as integer' do
      subject { repo.all_for('invalid') }

      it { expect { subject }.to raise_error(Sequel::DatabaseError) }
    end
  end
end
