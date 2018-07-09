class Projection
  def initialize
    @shifts = {}
  end

  def handle_event(event:, aggregate_id:)
    case event
    when Events::ShiftStarted
      @shifts[aggregate_id] = Projections::Shift.new(employee_id: event.employee_id, start_time: event.start_time, aggregate_id: aggregate_id)
    when Events::ShiftEnded
      @shifts[aggregate_id].end_time = event.end_time
    else
      raise NotImplementedError
    end
  end

  def shifts
    @shifts.values
  end

  def shift_by_id(aggregate_id)
    @shifts[aggregate_id]
  end
end
