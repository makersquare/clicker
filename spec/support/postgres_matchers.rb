require 'rspec/expectations'

# NOTE: This matcher does not work for multiple NOTIFY statements on the same channel
RSpec::Matchers.define :notify do |channel,payload|

  supports_block_expectations
  def diffable?
    @notified == true
  end

  match do |code|
    pg = PGconn.open(:dbname => 'clicker_test')
    pg.exec "LISTEN #{channel}"
    @notified = false

    code.call

    wait = Proc.new do
      pg.wait_for_notify(0.5) do |actual_channel, pid, actual_payload|
        return wait if channel != actual_channel

        @notified = true
        @actual = actual_payload
        expect(actual_payload).to eq payload
      end
    end

    wait.call
    expect(@notified).to eq true
  end

  failure_message do
    if @notified == false
      "Expected a NOTIFY on channel `#{channel}` (received nothing on that channel instead)"
    else
      "Expected a NOTIFY on channel `#{channel}`\n\tExpected payload: #{payload.inspect}\n\tGot payload: #{@actual.inspect}"
    end
  end
end
