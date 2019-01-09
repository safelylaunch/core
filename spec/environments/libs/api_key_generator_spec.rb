# frozen_string_literal: true

RSpec.describe Environments::Libs::ApiKeyGenerator, type: :operation do
  let(:operation) { described_class.new }
  let(:type) { Core::Types::UUID }

  subject { operation.call } 

  it { expect(type[subject]).to eq(subject) }
end
