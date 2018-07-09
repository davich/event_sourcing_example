require_relative 'event_store'
require_relative 'projector'
require_relative 'projection'
require_relative 'command_handler'
require_relative 'commands'
require_relative 'events'
require_relative 'shift'

class Application
  def run
    es = EventStore.new
    projection = Projection.new
    projector = Projector.new(es, projection)
    projector.run
    {
      command_handler: CommandHandler.new(es),
      projection: projection,
    }
  end
end
