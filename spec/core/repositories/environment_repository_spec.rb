# frozen_string_literal: true

RSpec.describe EnvironmentRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_for_token' do
    let(:environment) { Fabricate.create(:environment, api_key: 'tokenhere') }

    subject { repo.find_for_token(token) }

    context 'when token correct' do
      let(:token) { environment.api_key }

      it { expect(subject).to be_a(Environment) }
    end

    context 'when token incorrect' do
      let(:token) { 'other-token' }

      it { expect(subject).to eq(nil) }
    end
  end
end
