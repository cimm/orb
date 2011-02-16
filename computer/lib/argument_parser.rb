require 'ostruct'
require 'optparse'

class ArgumentParser
  # TODO -p and -l are not yet REQUIRED
  def self.parse(args)
    options = OpenStruct.new
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: parser.rb -p PORT"
      opts.separator ""
      opts.on("-p", "--port PORT", "Use PORT to connect with the Arduino bord") do |port|
        options.port = port
      end
      opts.on("-l", "--location YAHOO_WOEID", "Weather forecast at the given Yahoo! WOEID (eg. 966989 for Beauvechain)") do |location|
        options.location = location
      end
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
    opts.parse!(args)
    options
  end
end
