require 'nokogiri'
require 'open-uri'

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
    delay(connections_doc) > 0 ? true : false
  end

  private

  def load_feed
    connection_feed = FEED_BASE + "from=#{@origin}&to=#{@destination}"
    connections_doc = Nokogiri::XML(open(connection_feed))
  end

  def delay(connections_doc)
    delays = connections_doc.xpath("//connection/departure/@delay")
    raise IOError, "No delays found" if delays.empty?
    delays.first.to_s.to_i
  end
end
