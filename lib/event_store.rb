class EventStore
  def initialize
    @events = []
  end

  def put(event:, aggregate_id:)
    @events << {event: event, aggregate_id: aggregate_id}
  end

  def get_from(index)
    @events[index..-1]
  end

  def get_for_aggregate_id(id)
    @events.select { |event| event[:aggregate_id] == id }.map { |x| x[:event] }
  end
end
