require 'trollop'

class ArgumentParser
  SUB_COMMANDS = %w(weather delay gmail)

  def self.parse(argv)
    argv << "-h" if argv.empty?
    global_opts = Trollop::options do
      banner <<-EOS
Usage: ./orbifier PARSER [ARGS] [-h|--help] [-v|--verbose]

Available parsers:
  weather:\tWeather forecast for a given city
  delay:\tDelay for the next given Belgian train connection
  gmail:\tNew mail in my Gmail inbox

Global options:
EOS
      opt :verbose, "Verbose mode will print debug messages"
      stop_on SUB_COMMANDS
    end
    cmd = argv.shift
    cmd_opts = case cmd
      when "weather"
        Trollop::options do
          puts "Usage: ./orbifier weather -p|--port PORT -c|--city WOEID [-h|--help] [-v|--verbose]\n\n" # TODO Should be banner here
          opt :port, "The USB port used to connect with the Arduino bord", :type => :string
          opt :city, "Weather forecast for this city as a Yahoo! WOEID (eg. 966989 for Beauvechain)", :type => :int
          opt :verbose, "Verbose mode will print debug messages"
        end
      when "delay"
        Trollop::options do
          puts "Usage: ./orbifier delay -p|--port PORT -o|--origin STATION -d|--destination STATION [-h|--help] [-v|--verbose]\n\n" # TODO Should be banner here
          opt :port, "The USB port used to connect with the Arduino bord", :type => :string
          opt :origin, "Name of a Belgian station of origin (eg. Leuven)", :type => :string
          opt :destination, "Name of a Belgian destination station (eg. Wavre)", :type => :string
          opt :verbose, "Verbose mode will print debug messages"
        end
      when "gmail"
        Trollop::options do
          puts "Usage: ./orbifier gmail -p|--port PORT -a|--account ACCOUNT -p|--password PASSWORD [-h|--help] [-v|--verbose]\n\n" # TODO Should be banner here
          opt :port, "The USB port used to connect with the Arduino bord", :type => :string
          opt :account, "Your Gmail account", :type => :string
          opt :password, "Your Gmail password", :type => :string
          opt :verbose, "Verbose mode will print debug messages"
        end
      else Trollop::die "Unknown parser #{cmd.inspect}"
    end
    Trollop::die :port, "is required" if !cmd_opts[:port_given]
    Trollop::die :city, "is required" if !cmd_opts[:city_given] && cmd == "weather"
    Trollop::die :origin, "is required" if !cmd_opts[:origin_given] && cmd == "delay"
    Trollop::die :destination, "is required" if !cmd_opts[:destination_given] && cmd == "delay"
    Trollop::die :account, "is required" if !cmd_opts[:account_given] && cmd == "gmail"
    Trollop::die :password, "is required" if !cmd_opts[:password_given] && cmd == "gmail"
    cmd_opts.merge({:parser => cmd})
  end
end
