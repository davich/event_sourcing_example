class Shift
  class ShiftNotStarted < StandardError ; end
  def self.hydrate(events)
    self.new.tap do |shift|
      events.each do |event|
        shift.apply_event(event)
      end
    end
  end

  def handle(command)
    case command
    when Commands::StartShift
      Events::ShiftStarted.new(command.employee_id, command.start_time)
    when Commands::EndShift
      raise ShiftNotStarted unless @start_time && @employee_id
      Events::ShiftEnded.new(command.end_time)
    else
      raise NotImplementedError
    end
  end

  def apply_event(event)
    case event
    when Events::ShiftStarted
      @start_time = event.start_time
      @employee_id = event.employee_id
    when Events::ShiftEnded
      @end_time = event.end_time
    else
      raise NotImplementedError
    end
  end
end
