require 'parser'

class WeatherParser < Parser
  FEED_BASE = "http://weather.yahooapis.com/forecastrss?w="

  def initialize(city)
    raise ArgumentError, "Missing city" if city.nil?
    @city = city
  end

  def green?
    if cache_expired?
      OrbLogger.log("Weather cache expired")
      refresh
    end
    fair_conditions?
  end

  def cache_expired?
    if @expires_at
      Time.now > @expires_at
    else
      true
    end
  end

  private

  def refresh
    weather_doc = load_feed
    set_cache(weather_doc)
    @code = find_weather_code(weather_doc)
    OrbLogger.log("Weather code set to #{@code}")
  end

  def load_feed
    weather_feed = FEED_BASE + @city.to_s
    weather_doc = Nokogiri::XML(open(weather_feed))
    raise IOError, "City not found" if weather_doc.xpath("//title").first.to_s == "City not found"
    weather_doc
  end

  def find_weather_code(weather_doc)
    codes = weather_doc.xpath("//yweather:forecast/@code")
    raise IOError, "No weather codes received" if codes.empty?
    codes.first.to_s.to_i
  end

  def set_cache(weather_doc)
    duration = weather_doc.xpath("//ttl/text()").to_s.to_i
    OrbLogger.log("Weather cache set to #{duration} minutes")
    @expires_at = Time.now + (duration * 60)
  end

  def fair_conditions?
    case @code
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
      else raise ArgumentError, "Invalid weather code"
    end
  end
end
