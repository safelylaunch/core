# frozen_string_literal: true

RSpec.describe Toggle, type: :entity do
  describe 'boolean?' do
    subject { entity.boolean? }

    context 'when toggle has "boolean" type' do
      let(:entity) { Toggle.new(type: 'boolean') }

      it { expect(subject).to eq true }
    end

    context 'when toggle has other type' do
      it { expect { Toggle.new(type: 'other') }.to raise_error }
    end
  end

  describe 'enable?' do
    subject { entity.enable? }

    context 'when toggle has "enable" status' do
      let(:entity) { Toggle.new(status: 'enable') }

      it { expect(entity.enable?).to eq true }
      it { expect(entity.disable?).to eq false }
    end

    context 'when toggle has "disable" status' do
      let(:entity) { Toggle.new(status: 'disable') }

      it { expect(entity.enable?).to eq false }
      it { expect(entity.disable?).to eq true }
    end

    context 'when toggle has other status' do
      it { expect { Toggle.new(status: 'other') }.to raise_error }
    end
  end
end
