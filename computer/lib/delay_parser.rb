require 'nokogiri'
require 'open-uri'

class DelayParser < Parser
  def self.green?(origin, destination)
    next_connection_delay(origin, destination) > 0 ? true : false
  end

  private

  def self.next_connection_delay(origin, destination)
    irail_trains_feed = "http://api.irail.be/connections/?from=#{origin}&to=#{destination}"
    trains_doc = Nokogiri::XML(open(irail_trains_feed))
    trains = trains_doc.xpath("//connection/departure/@delay")
    trains.first.to_s.to_i
  end
end
