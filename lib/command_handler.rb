class CommandHandler
  class UnknownCommand < StandardError ; end
  def initialize(event_store)
    @event_store = event_store
  end

  def handle(command)
    events =
      aggregate(command)
        .hydrate(@event_store.get_for_aggregate_id(command.aggregate_id))
        .handle(command)

    events.each do |event|
      @event_store.put(event: event, aggregate_id: command.aggregate_id)
    end
  end

  private

  def aggregate(command)
    case command
    when Commands::StartShift, Commands::EndShift
      Aggregates::Shift
    else
      raise UnknownCommand
    end
  end
end
