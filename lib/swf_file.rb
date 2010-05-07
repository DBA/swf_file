$:.unshift File.join(File.dirname(__FILE__), 'swf_file') unless $:.include? File.join(File.dirname(__FILE__), 'swf_file')

require 'zlib'
require 'parser'
require 'compression'
require 'conversions'
require 'assertions'
require 'packed_bit_object'
require 'swf_header'

class SwfFile
  # Class methods
  def self.header(swf_path)
    raise RuntimeError, "SWF file not found.", caller unless File.exists?(swf_path)
    
    header = SwfHeader.new(swf_path)
    yield(header) if block_given?
    header
  end
  
  # Instance methods
  def initialize(swf_path)
    raise RuntimeError, "SWF file not found.", caller unless File.exists?(swf_path)
    
    @header = SwfHeader.new(swf_path)
  end
  
  def header
    yield(@header) if block_given?
    @header
  end
  
  def compressed?
    @header.compressed?
  end
end