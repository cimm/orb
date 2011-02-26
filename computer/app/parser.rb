require 'nokogiri'
require 'open-uri'
require 'logger'

class Parser
  def initialize(*args)
    raise NotImplementedError
  end

  def green?(*args)
    raise NotImplementedError
  end
end
