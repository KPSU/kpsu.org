require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'construct'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'code_statistics/code_statistics'

class Test::Unit::TestCase
end
