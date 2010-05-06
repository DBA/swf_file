$:.unshift File.join(File.dirname(__FILE__), 'swf_file') unless $:.include? File.join(File.dirname(__FILE__), 'swf_file')

require 'zlib'
require 'parser'
require 'compression'
require 'conversions'
require 'packed_bit_object'
require 'swf_header'

class SwfFile
  def initialize(swf_path)
    raise RuntimeError, "SWF file not found.", caller unless File.exists?(swf_path)
  end
  
  def self.header(swf_path)
    raise RuntimeError, "SWF file not found.", caller unless File.exists?(swf_path)
    
    SwfHeader.new(swf_path)
  end
end