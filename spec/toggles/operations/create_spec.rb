# frozen_string_literal: true

RSpec.describe Toggles::Operations::Create, type: :operation do
  let(:operation) { described_class.new(toggle_repo: toggle_repo) }
  let(:toggle_repo) { instance_double('ToggleRepository', create: toggle) }

  subject { operation.call() }

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:environment) { Fabricate.create(:environment) }

    subject { operation.call() }

    it { expect(subject).to be_success }
  end
end
