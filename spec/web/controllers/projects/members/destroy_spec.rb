# frozen_string_literal: true

RSpec.describe Web::Controllers::Projects::Members::Destroy, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, project_id: 123, id: 1 } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns a project' do
    let(:operation) { ->(*) { Success(:something) } }

    it { expect(subject).to redirect_to('/projects/123/members') }

    it do
      allow(operation).to receive(:call).with(member_id: 1, project_id: 123)
      subject
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something) } }

    it { expect(subject).to redirect_to('/projects/123/members') }
  end

  context 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:params) { { 'rack.session' => { account: Account.new(id: member.account_id) }, project_id: project.id, account_id: member.id } }

    let(:project) { Fabricate.create(:project, id: 1) }

    let(:member) { Fabricate.create(:project_member, project_id: project.id) }

    it { expect(subject).to redirect_to('/projects/1/members') }
  end
end
