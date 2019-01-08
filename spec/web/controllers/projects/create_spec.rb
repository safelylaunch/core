RSpec.describe Web::Controllers::Projects::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { { 'rack.session' => session } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  it { expect(subject).to redirect_to('/') }


  xcontext 'when user not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(subject).to redirect_to('/login') }
  end

  context 'whith real dependencies' do
    let(:action) { described_class.new }

  end
end
