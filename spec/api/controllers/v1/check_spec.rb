# frozen_string_literal: true

RSpec.describe Api::Controllers::V1::Check, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { key: 'test-toggle', environment_id: 1 } }

  subject { action.call(params) }

  context 'when toggle exist' do
    let(:operation) { ->(*) { Success(key: 'test-toggle', enable: true) } }

    it 'returns toggle status' do
      expect(subject).to be_success
      expect(subject).to include_json(key: 'test-toggle', enable: true)
    end
  end

  context 'when toggle does not exist' do
    let(:error_object) { ErrorObject.new(:not_found, key: 'test-toggle', environment_id: 1) }
    let(:operation) { ->(*) { Failure(error_object) } }

    it 'returns toggle status with error' do
      expect(subject).to have_http_status(400)
      expect(subject).to include_json(
        key: 'test-toggle',
        enable: false,
        error: {
          type: 'not_found',
          message: 'Toggle with key "test-toggle" not found',
          params: { key: 'test-toggle', environment_id: 1 }
        }
      )
    end
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:toggle) { Fabricate.create(:toggle) }
    let(:params) { { key: toggle.key, environment_id: toggle.environment_id } }

    it 'returns toggle status' do
      expect(subject).to be_success
      expect(subject).to include_json(key: 'test-toggle', enable: true)
    end
  end
end
