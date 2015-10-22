require_relative '../lib/errors'
require_relative '../lib/stage'
require_relative '../lib/scanner'
require_relative '../lib/node'
require_relative '../lib/robot'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each{|f| require f}

RSpec.configure do |c|

end
