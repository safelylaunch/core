# frozen_string_literal: true

RSpec.describe Api::Controllers::V1::Check, type: :action do
  let(:params) { { key: 'test-toggle', token: 'tokenhere' } }
  let(:action) do
    described_class.new(
      operation: operation,
      authorizer: authorizer
    )
  end

  subject { action.call(params) }

  context 'when customer sends valid token' do
    let(:authorizer) { ->(*) { Success(environment_id: 1) } }

    context 'and toggle exist' do
      let(:operation) { ->(*) { Success(key: 'test-toggle', enable: true) } }

      it 'returns toggle status' do
        expect(subject).to be_success
        expect(subject).to include_json(key: 'test-toggle', enable: true)
      end
    end

    context 'and toggle does not exist' do
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
            params: { key: 'test-toggle', token: 'tokenhere' }
          }
        )
      end
    end
  end

  context 'when customer sends invalid token' do
    let(:operation) { ->(*) { Success(key: 'test-toggle', enable: true) } }
    let(:authorizer) { ->(*) { Failure(error_object) } }
    let(:error_object) { ErrorObject.new(:auth_failure, token: 'tokenhere') }

    it 'returns toggle status with error' do
      expect(subject).to have_http_status(400)
      expect(subject).to include_json(
        key: 'test-toggle',
        enable: false,
        error: {
          type: 'auth_failure',
          message: 'Invalid token "tokenhere"',
          params: { key: 'test-toggle', token: 'tokenhere' }
        }
      )
    end
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:environment) { Fabricate.create(:environment, api_key: 'tokenhere') }
    let(:toggle) { Fabricate.create(:toggle, environment_id: environment.id) }
    let(:params) { { key: toggle.key, token: 'tokenhere' } }

    it 'returns toggle status' do
      expect(subject).to be_success
      expect(subject).to include_json(key: 'test-toggle', enable: true)
    end
  end
end
