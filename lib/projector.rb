class Projector
  def initialize(event_store, projection)
    @event_store = event_store
    @projection = projection
  end
  SLEEP_TIME = 0.1

  def run
    @current_event = 0
    Thread.new do
      loop do
        @event_store.get_from(@current_event).each do |event|
          @projection.handle_event(event)
          @current_event += 1
        end
        sleep SLEEP_TIME
      end
    end
  end
end
