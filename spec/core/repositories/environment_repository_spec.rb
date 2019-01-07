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
end
