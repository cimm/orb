require 'ostruct'
require 'optparse'

class ArgumentParser
  # TODO Find something for required arguments
  def self.parse(args)
    options = OpenStruct.new
    opts = case args.first
      when "weather" then weather_arguments
      when "delay" then delay_arguments
      else main_arguments
    end
    opts.parse!(args)
    unless args.include?("-h") || args.include?("--help")
      puts opts
    end
    options
  end

  def self.main_arguments
    OptionParser.new do |opts|
      opts.banner = "Usage: ./orbifier PARSER [ARGS] [-h|--help]"
      opts.separator ""
      opts.separator "Available commands:"
      opts.separator "   weather\tWeather forecast for a given location"
      opts.separator "   delay\tNext train delay for a given connection"
    end
  end

  def self.weather_arguments
    OptionParser.new do |opts|
      opts.banner = "Usage: ./orbifier weather -p|--port PORT -l|--location WOID [-h|--help]"
      opts.separator ""
      opts.on("-p", "--port PORT", "The USB port used to connect with the Arduino bord") do |port|
        options.port = port
      end
      opts.on("-l", "--location YAHOO_WOEID", "Weather forecast at the given Yahoo! WOEID (eg. 966989 for Beauvechain)") do |location|
        options.location = location
      end
    end
  end

  def self.delay_arguments
    OptionParser.new do |opts|
      opts.banner = "Usage: ./orbifier delay -p|--port PORT -f|--from STATION -t|--to STATION [-h|--help]"
      opts.separator ""
      opts.on("-p", "--port PORT", "The USB port used to connect with the Arduino bord") do |port|
        options.port = port
      end
      opts.on("-o", "--origin STATION", "Name of the Belgian station of orgin (eg. Leuven)") do |origin|
        options.origin = origin
      end
      opts.on("-d", "--destination STATION", "Name of the Belgian destination station (eg. Kortrtijk)") do |destination|
        options.destination = destination
      end
    end
  end
end
