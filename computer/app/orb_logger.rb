class OrbLogger
  @verbose = false

  def self.verbose=(value)
    @verbose = value
  end

  def self.log(message)
    if @verbose
      time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      Kernel.puts "#{time} - #{message}"
    end
  end
end
