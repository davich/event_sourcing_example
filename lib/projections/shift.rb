module Projections
  class Shift
    attr_accessor :aggregate_id, :start_time, :end_time, :employee_id

    def initialize(aggregate_id:, start_time:, end_time: nil, employee_id:)
      @aggregate_id = aggregate_id
      @start_time = start_time
      @end_time = end_time
      @employee_id = employee_id
    end

    def ==(other)
      aggregate_id == other.aggregate_id &&
        start_time == other.start_time &&
        end_time == other.end_time &&
        employee_id == other.employee_id
    end
  end
end
