$LOAD_PATH << './lib'
$LOAD_PATH << './app'

require 'orb'
require 'parser'

RSpec.configure do |config|
  config.mock_with :rspec
  use_transactional_fixtures = true
end

def suppress_stderr
  $stderr_backup = $stderr.dup
  $stderr.reopen('/dev/null', 'w')
  yield
  $stderr = $stderr_backup.dup
end
