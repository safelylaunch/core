# frozen_string_literal: true

RSpec.describe Web::Controllers::Auth::Login, type: :action do
  let(:action) { described_class.new }
  let(:params) { { 'rack.session' => session } }

  subject { action.call(params) }

  context 'when account is login' do
    let(:session) { { account: Account.new(id: 1) } }

    it { expect(subject).to redirect_to('/') }
  end

  context 'when account is not login' do
    let(:session) { {} }

    it { expect(subject[0]).to eq 200 }
  end
end

