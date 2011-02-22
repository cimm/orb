require 'serialport'

class Orb
  def initialize(port)
    begin
      @serial = SerialPort.new(port, 9600, 8, 1, SerialPort::NONE) # will reset the Arduino
      sleep(5)
    rescue
      puts "Could not open serial port: #{port}"
      exit(1)
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
  end

  private

  def update(color, status)
    # G or R means green or red on, g or r means green or red off
    if status == :on
      @serial.write color.upcase
      puts "LED #{color} ON" # DEBUG
    else
      @serial.write color.downcase
      puts "LED #{color} OFF" # DEBUG
    end
    sleep(10) # TODO Connection has to stay open or the Arduino will reset
  end
end
