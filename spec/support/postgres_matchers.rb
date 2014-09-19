require 'rspec/expectations'

# NOTE: This matcher does not work for multiple NOTIFY statements on the same channel
# RSpec::Matchers.define :notify do |channel,payload,&match_block|
module NotifyMatcher

  def notify(*args, &block)
    Notify.new(*args, &block)
  end

  class Notify

    def initialize(channel, payload=nil, &payload_block)
      @channel = channel
      @payload = payload
      @payload_block = payload_block if block_given?
    end

    def supports_block_expectations?
      true
    end

    def diffable?
      @notified == true
    end

    def matches?(code)
      pg = PGconn.open(:dbname => 'clicker_test')
      pg.exec "LISTEN #{@channel}"
      @notified = false

      code.call

      payload_matches = nil

      wait = Proc.new do
        pg.wait_for_notify(0.5) do |actual_channel, pid, actual_payload|
          return wait if @channel != actual_channel

          @notified = true
          @actual = actual_payload
          
          payload_matches = actual_payload == @payload if @payload
          @payload_block.call(actual_payload) if @payload_block
        end
      end

      wait.call
      if @payload
        @notified == true && payload_matches == true
      else
        @notified == true
      end
    end

    def failure_message
      if @notified == false
        "Expected a NOTIFY on channel `#{@channel}` (received nothing on that channel instead)"
      else
        "Expected a NOTIFY on channel `#{@channel}`\n\tExpected payload: #{@payload.inspect}\n\tGot payload: #{@actual.inspect}"
      end
    end
  end
end

RSpec.configure do |config|
  config.include(NotifyMatcher)
end
