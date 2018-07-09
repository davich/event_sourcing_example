class Events
  ShiftStarted = Struct.new(:employee_id, :start_time) do
  end
  ShiftEnded = Struct.new(:end_time) do
  end
end
