require 'spec_helper'

describe 'orb logger' do
  describe :verbose= do
    it "sets the verbose flag to true" do
      OrbLogger.verbose = true
    end

    it "sets the verbose flag to false" do
      OrbLogger.verbose = false
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
      formatted_date = now.strftime('%Y-%m-%d %H:%M:%S')
      OrbLogger.verbose = true
      Time.should_receive(:now).and_return now
      now.should_receive(:strftime).with('%Y-%m-%d %H:%M:%S').and_return formatted_date
      Kernel.should_receive(:puts).with("#{formatted_date} - Some log message")
      OrbLogger.log("Some log message")
    end
  end
end
