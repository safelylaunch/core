class ToggleCounterRepository < Hanami::Repository
  def increase_today_counter(toggle_id)
    transaction do
      if today_counter = find_for_today(toggle_id)
        update(today_counter.id, count: today_counter.count + 1)
      else
        create(toggle_id: toggle_id, count: 1)
      end
    end
  end

private

  def find_for_today(toggle_id)
    root
      .where(toggle_id: toggle_id)
      .where { time::date_trunc('day', created_at).is(time::date_trunc('day', date::now)) }
      .map_to(ToggleCounter).one
  end
end
