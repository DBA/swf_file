$:.unshift File.join(File.dirname(__FILE__),".")
require 'zlib'
module SwfUtil
  class SWFDecompressor<SWFCompression 
    def initialize(from=nil,to=nil)
      read_file(from,to) if !from.nil? and !to.nil?
    end
    def read_file(file,to) 
      swf=File.open(file,"rb") do |f|
        f.read
      end
      raise RuntimeError.new,"The file have not been compressed",caller if  !is_compressed?(swf[0])
      decomp=uncompress(swf)
      File.open(to,"wb") do |f|
        f.write(decomp)
      end  
    end
    def uncompress(bytes)
      decompressor =Zlib::Inflate.new
      swf=decompressor.inflate(strip_header(bytes))
      swf=bytes[0,8]+swf
      swf[0] = ?F
      swf
    end
  end
end
