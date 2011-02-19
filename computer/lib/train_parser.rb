require 'nokogiri'
require 'open-uri'

class TrainParser
  def self.delayed?(from, to)
    next_connection_delay(from, to) > 0 ? true : false
  end

  private

  def self.next_connection_delay(from, to)
    irail_trains_feed = "http://api.irail.be/connections/?from=#{from}&to=#{to}"
    trains_doc = Nokogiri::XML(open(irail_trains_feed))
    trains = trains_doc.xpath("//connection/departure/@delay")
    raise "No trains found." if trains.count == 0
    trains.first.to_s.to_i
  end
end
