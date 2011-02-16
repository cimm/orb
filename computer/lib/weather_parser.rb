require 'nokogiri'
require 'open-uri'

class WeatherParser
  def self.nice_weather?(location)
    code = find_weather_code(location)
    fair_conditions?(code)
  end

  private

  def self.find_weather_code(location)
    yahoo_weather_feed = "http://weather.yahooapis.com/forecastrss?w=#{location}"
    weather_doc = Nokogiri::XML(open(yahoo_weather_feed))
    cache_time = weather_doc.xpath("//ttl/@code").to_s.to_i # TODO Yahoo asks to cache this feed for ttl minutes
    code = weather_doc.xpath("//yweather:forecast/@code").first.to_s.to_i
    puts "Weather code: #{code}" # DEBUG
    code
    # TODO Raise if not found
  end
  
  def self.fair_conditions?(code)
    case code
      when 0 then return false # tornado
      when 1 then return false # tropical storm
      when 2 then return false # hurricane
      when 3 then return false # severe thunderstorms
      when 4 then return false # thunderstorms
      when 5 then return false # mixed rain and snow
      when 6 then return false # mixed rain and sleet
      when 7 then return false # mixed snow and sleet
      when 8 then return false # freezing drizzle
      when 9 then return false # drizzle
      when 10 then return false # freezing rain
      when 11 then return false # showers
      when 12 then return false # showers
      when 13 then return false # snow flurries
      when 14 then return false # light snow showers
      when 15 then return false # blowing snow
      when 16 then return false # snow
      when 17 then return false # hail
      when 18 then return false # sleet
      when 19 then return false # dust
      when 20 then return false # foggy
      when 21 then return false # haze
      when 22 then return false # smoky
      when 23 then return false # blustery
      when 24 then return false # windy
      when 25 then return false # cold
      when 26 then return false # cloudy
      when 27 then return true # mostly cloudy (night)
      when 28 then return true # mostly cloudy (day)
      when 29 then return true # partly cloudy (night)
      when 30 then return true # partly cloudy (day)
      when 31 then return true # clear (night)
      when 32 then return true # sunny
      when 33 then return true # fair (night)
      when 34 then return true # fair (day)
      when 35 then return false # mixed rain and hail
      when 36 then return true # hot
      when 37 then return false # isolated thunderstorms
      when 38 then return false # scattered thunderstorms
      when 39 then return false # scattered thunderstorms
      when 40 then return false # scattered showers
      when 41 then return false # heavy snow
      when 42 then return false # scattered snow showers
      when 43 then return false # heavy snow
      when 44 then return false # partly cloudy
      when 45 then return false # thundershowers
      when 46 then return false # snow showers
      when 47 then return false # isolated thundershowers
      else return false # not available or gibberish
    end
  end
end
