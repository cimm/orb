require 'parser'

class DelayParser < Parser
  FEED_BASE = "http://api.irail.be/connections/?"

  def initialize(origin, destination)
    raise ArgumentError, "Missing origin station" if origin.nil?
    raise ArgumentError, "Missing destination station" if destination.nil?
    @origin = origin
    @destination = destination
  end

  def green?
    connections_doc = load_feed
    log_connection(connections_doc)
    delayed?(connections_doc) ? false : true # Green should be true when delay is false
  end

  private

  def load_feed
    connection_feed = FEED_BASE + "from=#{@origin}&to=#{@destination}"
    connections_doc = Nokogiri::XML(open(connection_feed))
  end

  def delay(connections_doc)
    delays = connections_doc.xpath("//connection/departure/@delay")
    raise IOError, "No delays found" if delays.empty?
    Logger.log("Connection has a delay of #{delays.first.to_s} seconds")
    delays.first.to_s.to_i
  end

  def delayed?(connections_doc)
    delay(connections_doc) > 0
  end

  def log_connection(connections_doc)
    origin = connections_doc.xpath("//connection/departure/station/text()").first.to_s
    destination = connections_doc.xpath("//connection/arrival/station/text()").first.to_s
    Logger.log("Using connection from #{origin} to #{destination}")
  end
end
