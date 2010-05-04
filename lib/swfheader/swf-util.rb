module SwfUtil
  def self.read_header(file)
    raise ArgumentError.new("file is nil",caller) if file.nil? 
    SWFHeader.new(file)
  end
  def self.compress_swf(from,to=from.sub(/\.swf/,'_comp.swf'))
    raise ArgumentError.new("file is nil",caller) if from.nil?
    SWFCompressor.new(from,to)
  end
  def self.decompress_swf(from,to=from.sub(/\.swf/,'de_comp.swf'))
    raise ArgumentError.new("file is nil",caller) if from.nil?
    SWFDecompressor.new(from,to)
  end
end