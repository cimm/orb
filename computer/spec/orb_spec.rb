require 'spec_helper'

describe 'orb' do
  describe :new do
    let(:serial) { mock(SerialPort) }

    it "creates a new orb" do
      SerialPort.stub!(:new => serial)
      SerialPort.should_receive(:new).with("/some/port", 9600, 8, 1, SerialPort::NONE).and_return serial
      Kernel.should_receive(:sleep).with(5)
      Logger.should_receive(:log).with("Connection open")
      Orb.new("/some/port").should be_an_instance_of(Orb)
    end

    it "fails when the serial port doesn't exists" do
      SerialPort.should_receive(:new).and_raise(RuntimeError)
      lambda do
        suppress_stderr { Orb.new("/some/port", 0) }
      end.should raise_error(SystemExit, "Could not open serial port: /some/port")
    end

  end

  describe :green do
    let(:serial) { mock(SerialPort) }
    let(:orb) do # TODO Do I really need all this?
      SerialPort.stub!(:new => serial)
      SerialPort.should_receive(:new).with("/some/port", 9600, 8, 1, SerialPort::NONE).and_return serial
      Logger.should_receive(:log).with("Connection open")
      Orb.new("/some/port", 0)
    end

    it "truns on the green LED" do
      orb.should_receive(:update).with("g", :on)
      orb.green(:on) # TODO Can I have an expectation here?
    end

    it "truns off the green LED" do
      orb.should_receive(:update).with("g", :off)
      orb.green(:off)
    end
  end

  describe :red do
    let(:serial) { mock(SerialPort) }
    let(:orb) do
      SerialPort.stub!(:new => serial)
      SerialPort.should_receive(:new).with("/some/port", 9600, 8, 1, SerialPort::NONE).and_return serial
      Logger.should_receive(:log).with("Connection open")
      Orb.new("/some/port", 0)
    end

    it "truns on the red LED" do
      orb.should_receive(:update).with("r", :on)
      orb.red(:on)
    end

    it "truns off the red LED" do
      orb.should_receive(:update).with("r", :off)
      orb.red(:off)
    end
  end

  describe :close do
    let(:serial) { mock(SerialPort) }
    let(:orb) do
      SerialPort.stub!(:new => serial)
      SerialPort.should_receive(:new).with("/some/port", 9600, 8, 1, SerialPort::NONE).and_return serial
      Logger.should_receive(:log).with("Connection open")
      Orb.new("/some/port", 0)
    end

    it "closes the serial connection" do
      serial.should_receive(:close)
      Logger.should_receive(:log).with("Connection closed")
      orb.close
    end
  end
end
