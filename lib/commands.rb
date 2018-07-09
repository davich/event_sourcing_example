require 'time'

class Commands
  class StartShift
    attr_reader :start_time, :employee_id, :aggregate_id

    def initialize(params)
      @aggregate_id = params[:aggregate_id]
      @start_time = params[:start_time]
      @employee_id = params[:employee_id]
    end
  end

  class EndShift
    attr_reader :end_time, :aggregate_id

    def initialize(params)
      @aggregate_id = params[:aggregate_id]
      @end_time = params[:end_time]
    end
  end
end
