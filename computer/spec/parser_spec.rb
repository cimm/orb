require 'spec_helper'

# Fake method to bypass the NotImplementedError for the initializer
class TestParser < Parser
  def initialize
  end
end

describe 'parser' do
  describe :new do
    it "raises a not implemented error" do
      lambda {
        Parser.new
      }.should raise_error(NotImplementedError)
    end
  end

  describe :green? do
    it "raises a not implemented error" do
      parser = TestParser.new
      lambda {
        parser.green?
      }.should raise_error(NotImplementedError)
    end
  end
end
