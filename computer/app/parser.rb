require 'nokogiri'
require 'open-uri'
require 'orb_logger'

class Parser
  def initialize(*args)
    raise NotImplementedError
  end

  def green?(*args)
    raise NotImplementedError
  end
end
