RSpec.describe Web::Controllers::Project::Members::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { { 'rack.session' => session, project_id: 123 } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  it { expect(subject).to redirect_to('/projects/123') }
end
