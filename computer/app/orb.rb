require 'serialport'
require 'logger'

class Orb
  def initialize(port, delay=5)
    begin
      @serial = SerialPort.new(port, 9600, 8, 1, SerialPort::NONE) # will reset the Arduino
      Kernel.sleep(delay)
      OrbLogger.log("Connection open")
    rescue
      abort "Could not open serial port: #{port}"
    end
  end

  def green(status)
    update("g", status)
  end

  def red(status)
    update("r", status)
  end

  def close
    @serial.close # will reset the Arduino
    OrbLogger.log("Connection closed")
  end

  private

  def update(color, status)
    # G or R means green or red on, g or r means green or red off
    if status == :on
      @serial.write color.upcase
      OrbLogger.log("#{color_name(color)} LED turned on")
    else
      @serial.write color.downcase
      OrbLogger.log("#{color_name(color)} LED turned off")
    end
  end

  def color_name(color)
    if color.casecmp("g") == 0
      return "Green"
    elsif color.casecmp("r") == 0
      return "Red"
    end
  end
end
