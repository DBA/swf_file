$:.unshift File.join(File.dirname(__FILE__), 'swf_file') unless $:.include? File.join(File.dirname(__FILE__),
                                                                                      'swf_file')

require 'zlib'

module SwfFile

  autoload :FlashFile,        'lib/swf_file/flash_file'
  autoload :Parser,           'lib/swf_file/parser'
  autoload :Compression,      'lib/swf_file/compression'
  autoload :Conversions,      'lib/swf_file/conversions'
  autoload :Assertions,       'lib/swf_file/assertions'
  autoload :PackedBitObject,  'lib/swf_file/packed_bit_object'
  autoload :SwfHeader,        'lib/swf_file/swf_header'

end # SwfFile
