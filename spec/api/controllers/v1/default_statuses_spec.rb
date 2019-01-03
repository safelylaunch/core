# frozen_string_literal: true

RSpec.describe Api::Controllers::V1::DefaultStatuses, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { environment_id: 1 } }

  subject { action.call(params) }

  context 'when environment contain toggles' do
    let(:toggle) do
      Toggle.new(
        key: 'test-toggle',
        environment_id: 1,
        name: 'test toggle',
        type: 'boolean',
        status: 'enable',
        default_status: 'disable'
      )
    end

    let(:operation) { ->(*) { Success([toggle]) } }

    it 'returns list of objects' do
      expect(subject).to be_success
      expect(subject).to include_json(
        toggles: [
          { key: 'test-toggle', type: 'boolean', enable: true, default_status: 'disable' }
        ]
      )
    end
  end

  context 'when toggle does not exist' do
    let(:operation) { ->(*) { Failure(Object.new) } }

    it 'returns toggle status with error' do
      expect(subject).to have_http_status(400)
      expect(subject).to include_json(
        error: {
          type: 'server_error',
          message: 'Server Error',
          params: { environment_id: 1 }
        }
      )
    end
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:toggle) { Fabricate.create(:toggle, key: 'test-toggle', status: 'enable') }
    let(:params) { { environment_id: toggle.environment_id } }

    it 'returns toggle status' do
      expect(subject).to be_success
      expect(subject).to include_json(
        toggles: [
          { key: 'test-toggle', type: 'boolean', enable: true, default_status: 'disable' }
        ]
      )
    end
  end
end
