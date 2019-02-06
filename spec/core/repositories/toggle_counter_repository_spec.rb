# frozen_string_literal: true

RSpec.describe ToggleCounterRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:toggle) { Fabricate.create(:toggle) }
  let(:one_day_before) { Time.now - 24 * 60 * 60 }

  describe '#increase_today_counter' do
    subject { repo.increase_today_counter(toggle.id) }

    let(:yesterday_counter) { repo.create(toggle_id: toggle.id, count: 10, created_at: one_day_before) }
    let(:today_counter) { repo.create(toggle_id: toggle.id, count: 10, created: Time.now) }

    context 'when toggle counter exists for today' do
      before { yesterday_counter && today_counter }

      it 'increase counter for existed object' do
        expect { subject }.to change { repo.all.count }.by(0)
        expect(repo.find(today_counter.id).count).to eq(11)
      end
    end

    context 'when toggle counter does not exist' do
      before { yesterday_counter }

      let(:today_counter) { repo.root.order { created_at.desc }.limit(1).one }

      it 'increase counter for existed object' do
        expect { subject }.to change { repo.all.count }.by(1)
        expect(today_counter.count).to eq(1)
      end
    end
  end
end
