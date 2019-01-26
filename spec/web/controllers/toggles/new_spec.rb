# frozen_string_literal: true

RSpec.describe Web::Controllers::Toggles::New, type: :action do
  let(:action) { described_class.new(projects_operation: projects_operation) }
  let(:params) { { 'rack.session' => session } }
  let(:session) { { account: Account.new(id: 1) } }
  let(:projects_operation) { ->(*) { Success([Project.new(id: 321)]) } }

  subject { action.call(params) }

  it { expect(subject).to be_success }

  it do
    subject

    expect(action.projects.size).to eq(1)
    expect(action.projects).to all(be_a(Project))
  end

  context 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:params) { { 'rack.session' => { account: account } } }

    let(:environment) { Fabricate.create(:environment) }
    let(:account) { Fabricate.create(:account, id: 1) }

    before { Fabricate.create(:project_member, project_id: environment.project_id, account_id: account.id) }

    it { expect(subject).to be_success }
  end
end
