require 'nokogiri'
require 'open-uri'

class DelayParser < Parser
  def self.green?(origin, destination)
    raise ArgumentError, "Missing origin or destination station" if origin.nil? || destination.nil?
    next_connection_delay(origin, destination) > 0 ? true : false
  end

  private

  def self.next_connection_delay(origin, destination)
    irail_connection_feed = "http://api.irail.be/connections/?from=#{origin}&to=#{destination}"
    connections_doc = Nokogiri::XML(open(irail_connection_feed))
    delays = connections_doc.xpath("//connection/departure/@delay")
    raise IOError, "No delays found" if delays.empty?
    delays.first.to_s.to_i
  end
end
