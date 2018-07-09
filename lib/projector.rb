class Projector
  def initialize(event_store, projection)
    @event_store = event_store
    @projection = projection
  end

  def run
    @current_event = 0
    Thread.new do
      loop do
        @event_store.get_from(@current_event).each do |event|
          @projection.handle_event(event)
          @current_event += 1
        end
        sleep 1
      end
    end
  end
end
