RSpec.describe Web::Controllers::ToggleStatuses::Update, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, toggle: { id: 5 }, project_id: 12, environment_id: 1 } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns empty list of project' do
    let(:operation) { ->(*) { Success(Toggle.new(id: 5)) } }

    it { expect(subject).to redirect_to('/projects/12/environments/1') }

    it do
      allow(operation).to receive(:call).with(id: 5)
      subject
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something) } }

    it { expect(subject).to redirect_to('/projects/12/environments/1') }
  end

  xcontext 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'whith real dependencies' do
    let(:action) { described_class.new }
    let(:params) do
      {
        'rack.session' => session,
        environment_id: environment.id,
        project_id: environment.project_id, 
        toggle: {
          id: toggle.id
        }
      }
    end
    let(:session) { { account: Account.new(id: 1) } }

    let(:environment) { Fabricate.create(:environment, id: 1) }
    let(:toggle) { Fabricate.create(:toggle, environment_id: environment.id) }

    it { expect(subject).to redirect_to("/projects/#{environment.project_id}/environments/#{environment.id}") }
  end
end
