$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems' if RUBY_VERSION =~ /1\.8.+/
require 'test/unit'
require 'shoulda'
require 'ruby-debug'
require 'swf_file'

def fixture_path(filename)
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end