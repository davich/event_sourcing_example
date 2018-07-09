require_relative '../lib/application'

describe Application do
  before do
    app = Application.new.run
    @command_handler = app[:command_handler]
    @projection = app[:projection]
  end

  it 'raises an error with an unknown command' do
    expect do
      @command_handler.handle("unkonwn")
    end.to raise_error(CommandHandler::UnknownCommand)
  end

  it 'starts and ends a shift' do
    start_time = Time.now.iso8601
    @command_handler.handle(Commands::StartShift.new(aggregate_id: '1234', start_time: start_time, employee_id: 4))
    sleep 1
    expect(@projection.shift_by_id('1234')).to eq(
      Projections::Shift.new(start_time: start_time, employee_id: 4, aggregate_id: '1234')
    )

    end_time = Time.now.iso8601
    @command_handler.handle(Commands::EndShift.new(aggregate_id: '1234', end_time: end_time))
    sleep 1
    expect(@projection.shift_by_id('1234')).to eq(
      Projections::Shift.new(start_time: start_time, employee_id: 4, end_time: end_time, aggregate_id: '1234')
    )
  end

  it 'starts multiple shifts' do
    start_time = Time.now.iso8601
    @command_handler.handle(Commands::StartShift.new(aggregate_id: '1234', start_time: start_time, employee_id: 4))
    @command_handler.handle(Commands::StartShift.new(aggregate_id: '5678', start_time: start_time, employee_id: 5))
    sleep 1
    expect(@projection.shifts).to eq([
      Projections::Shift.new(start_time: start_time, employee_id: 4, aggregate_id: '1234'),
      Projections::Shift.new(start_time: start_time, employee_id: 5, aggregate_id: '5678'),
    ])
  end

  it "errors when ending a shift that hasn't started" do
    expect do
      @command_handler.handle(Commands::EndShift.new(aggregate_id: '0000', end_time: Time.now.iso8601))
    end.to raise_error(Aggregates::Shift::ShiftNotStarted)
  end
end
