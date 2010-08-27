swf_file_path = File.join(File.dirname(__FILE__), 'swf_file')
$:.unshift swf_file_path unless $:.include? swf_file_path

require 'zlib'

module SwfFile

  autoload :FlashFile,        'flash_file'
  autoload :Parser,           'parser'
  autoload :Compression,      'compression'
  autoload :Conversions,      'conversions'
  autoload :Assertions,       'assertions'
  autoload :PackedBitObject,  'packed_bit_object'
  autoload :SwfHeader,        'swf_header'

end # SwfFile
