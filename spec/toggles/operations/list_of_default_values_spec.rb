# frozen_string_literal: true

RSpec.describe Toggles::Operations::ListOfDefaultValues, type: :operation do
  let(:operation) { described_class.new(toggle_repo: toggle_repo) }
  let(:toggle_repo) { instance_double('ToggleRepository', all_for: [Toggle.new]) }

  subject { operation.call(environment_id: environment_id) }
  let(:environment_id) { 1 }

  context 'when DB contain something' do
    it 'returns list of environment toggles' do
      expect(subject).to be_success
      expect(subject.value!).to eq [Toggle.new]
    end

    it { expect(subject).to be_a(Dry::Monads::Result) }
  end

  context 'when environment_id invalid and reporitory call raise error' do
    before { allow(toggle_repo).to receive(:all_for).and_raise(Sequel::DatabaseError.new) }

    it { expect(subject).to be_failure }
    it { expect(subject).to be_a(Dry::Monads::Result) }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:environment) { Fabricate.create(:environment) }

    subject { operation.call(environment_id: environment.id) }

    before do
      Fabricate.create(:toggle, environment_id: environment.id, key: 'test1')
      Fabricate.create(:toggle, environment_id: environment.id, key: 'test2')
    end

    it 'returns list of environment toggles' do
      expect(subject).to be_success
      expect(subject.value!.count).to eq 2
      expect(subject.value!).to all(be_a(Toggle))
    end
  end
end
