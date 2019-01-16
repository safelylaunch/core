# frozen_string_literal: true

RSpec.describe Toggles::Operations::Create, type: :operation do
  let(:operation) { described_class.new(toggle_repo: toggle_repo) }
  let(:toggle_repo) { instance_double('ToggleRepository', create: toggle) }
  let(:toggle) { Toggle.new(id: 1) }

  subject { operation.call(payload) }

  let(:payload) do
    {
      environment_id: 1,
      key: 'enable-toggles',
      name: 'test toggle',
      description: 'have no idea what say here',
      type: 'boolean',
      status: 'enable',
      tags: 'tech, test , other ,core'
    }
  end

  context 'when data is valid and all is okay' do
    it { expect(subject).to be_success }

    it 'splits tags right' do
      expect(toggle_repo).to receive(:create).with(**payload, tags: %w[tech test other core])
      subject
    end
  end

  context 'when data is invalid' do
    context 'and status invalid' do
      let(:payload) do
        {
          environment_id: 1,
          key: 'enable-toggles',
          name: 'test toggle',
          description: 'have no idea what say here',
          type: 'boolean',
          status: 'invalid'
        }
      end

      it { expect(subject).to be_failure }
    end

    context 'and type invalid' do
      let(:payload) do
        {
          environment_id: 1,
          key: 'enable-toggles',
          name: 'test toggle',
          description: 'have no idea what say here',
          type: 'invalid',
          status: 'enable',
          tags: 'tech, test , other ,core'
        }
      end

      it { expect(subject).to be_failure }
    end

    context 'and something missing' do
      let(:payload) do
        {
          environment_id: 1,
          name: 'test toggle',
          description: 'have no idea what say here',
          type: 'invalid',
          status: 'enable'
        }
      end

      it { expect(subject).to be_failure }
    end
  end

  context 'when repository can not create a record' do
    before do
      allow(toggle_repo).to receive(:create).and_raise(Hanami::Model::UniqueConstraintViolationError)
    end

    it { expect(subject).to be_failure }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:environment) { Fabricate.create(:environment) }

    let(:payload) do
      {
        environment_id: environment.id,
        key: 'enable-toggles',
        name: 'test toggle',
        description: 'have no idea what say here',
        type: 'boolean',
        status: 'enable'
      }
    end

    subject { operation.call(payload) }

    it { expect(subject).to be_success }
  end
end
