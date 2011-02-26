class Logger
  def self.verbose
    @verbose ||= false
  end

  def self.verbose=(value)
    @verbose = value
  end

  def self.log(message)
    if @verbose
      time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      puts "#{time} - #{message}"
    end
  end
end
