require 'parser'
require 'json'

class NodeciParser < Parser
  def initialize(monitor)
    raise ArgumentError, "Missing build monitor URL" if monitor.nil?
    @monitor = monitor
  end

  def green?
    builds = load_builds
    last_build_successful?(builds)
  end

  private

  def load_builds
    monitor_uri = URI.parse("#{@monitor}/builds")
    response = Net::HTTP.get_response(monitor_uri)
    builds = JSON.parse(response.body)
    raise IOError, "No builds found" if builds.empty?
    builds
  end

  def last_build_successful?(builds)
    builds.first['succeeded'] == true
  end
end
