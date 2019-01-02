# frozen_string_literal: true

RSpec.describe ErrorObject do
  subject { described_class.new(:not_found, payload) }

  context 'when payload is not empty' do
    let(:payload) { { key: 'test-toggle' } }

    it 'works correctly' do
      expect(subject.key).to eq(:not_found)
      expect(subject.payload).to eq(key: 'test-toggle')
    end
  end

  context 'when payload is empty' do
    let(:payload) { {} }

    it 'works correctly' do
      expect(subject.key).to eq(:not_found)
      expect(subject.payload).to eq({})
    end
  end
end
