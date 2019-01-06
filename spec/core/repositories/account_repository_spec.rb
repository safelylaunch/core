# frozen_string_literal: true

RSpec.describe AccountRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_by_email' do
    subject { repo.find_by_email(email) }

    before { Fabricate.create(:account, email: 'anton@test.com') }

    context 'when account exist in DB' do
      let(:email) { 'anton@test.com' }

      it { expect(subject).to be_a(Account) }
    end

    context 'when account does not exist in DB' do
      let(:email) { 'other@test.com' }

      it { expect(subject).to be(nil) }
    end
  end
end
