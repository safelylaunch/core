# frozen_string_literal: true

RSpec.describe Api::Controllers::V1::DefaultStatuses, type: :action do
  let(:action) { described_class.new(operation: operation, authorizer: authorizer) }
  let(:params) { { token: uuid } }
  let(:uuid) { SecureRandom.uuid }

  subject { action.call(params) }

  context 'when customer sends valid token' do
    let(:authorizer) { ->(*) { Success(environment_id: 1) } }

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
            params: { token: uuid }
          }
        )
      end
    end
  end

  context 'when customer sends invalid token' do
    let(:operation) { ->(*) { Success(key: 'test-toggle', enable: true) } }
    let(:authorizer) { ->(*) { Failure(error_object) } }
    let(:error_object) { ErrorObject.new(:auth_failure, token: uuid) }

    it 'returns toggle status with error' do
      expect(subject).to have_http_status(400)
      expect(subject).to include_json(
        error: {
          type: 'auth_failure',
          message: "Invalid token \"#{uuid}\"",
          params: { token: uuid }
        }
      )
    end
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:environment) { Fabricate.create(:environment, api_key: uuid) }
    let(:params) { { token: uuid } }

    before do
      Fabricate.create(:toggle, key: 'test-toggle', environment_id: environment.id, status: 'enable')
    end

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
