require 'nokogiri'
require 'open-uri'

class Parser
  def initialize(*args)
    raise NotImplementedError
  end

  def green?(*args)
    raise NotImplementedError
  end
end
