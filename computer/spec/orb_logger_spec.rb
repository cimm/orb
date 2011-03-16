require 'spec_helper'

describe 'orb logger' do
  describe :verbose= do
    it "sets the verbose flag to true" do
      OrbLogger.verbose = true # TODO Is this enough for testing a setter method?
    end

    it "sets the verbose flag to false" do
      OrbLogger.verbose = false # TODO Is this enough for testing a setter method?
    end
  end

  describe :log do
    it "should not print the log message by default" do
      now = Time.now
      Time.should_not_receive(:now).and_return now
      now.should_not_receive(:strftime).with('%Y-%m-%d %H:%M:%S')
      OrbLogger.log("Some log message")
    end

    it "should print the log message" do
      now = Time.now
      OrbLogger.verbose = true
      Time.should_receive(:now).and_return now
      now.should_receive(:strftime).with('%Y-%m-%d %H:%M:%S')
      Kernel.should_receive(:puts) # Can't use the message here as I stub Time
      OrbLogger.log("Some log message")
    end
  end
end
