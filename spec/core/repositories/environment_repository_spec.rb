# frozen_string_literal: true

RSpec.describe EnvironmentRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:uuid) { SecureRandom.uuid }

  describe '#find_for_token' do
    before { Fabricate.create(:environment, api_key: uuid) }

    subject { repo.find_for_token(token) }

    context 'when token correct' do
      let(:token) { uuid }

      it { expect(subject).to be_a(Environment) }
    end

    context 'when token incorrect' do
      let(:token) { 'other-token' }

      it { expect(subject).to eq(nil) }
    end
  end

  describe '#find_with_toggles' do
    subject { repo.find_with_toggles(env_id) }

    let(:environment) { Fabricate.create(:environment) }

    before { Fabricate.create(:toggle, environment_id: environment.id) }

    context 'when project id exist in db' do
      let(:env_id) { environment.id }

      it { expect(subject).to be_a(Environment) }
      it { expect(subject.toggles.count).to eq(1) }
      it { expect(subject.toggles).to all(be_a(Toggle)) }
    end

    context 'when project does not contain any members' do
      let(:env_id) { 0 }

      it { expect(subject).to eq(nil) }
    end
  end
end
