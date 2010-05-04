require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'swiff'

def fixture_path(filename)
  File.join(File.dirname(__FILE__), '..', 'fixtures', filename)
end