$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'swfheader'
#read swf header
swfheader=SwfUtil::read_header(File.join(File.dirname(__FILE__),".","test.swf"))
puts swfheader.inspect
#decompress swf
SwfUtil::decompress_swf(File.join(File.dirname(__FILE__),".","test.swf"),
                   File.join(File.dirname(__FILE__),".","test2.swf"))
#compress swf
SwfUtil::compress_swf(File.join(File.dirname(__FILE__),".","test2.swf"),
                   File.join(File.dirname(__FILE__),".","test3.swf"))