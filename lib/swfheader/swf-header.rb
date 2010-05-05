module SwfUtil
  class SWFHeader < SWFCompression
    attr_reader :file, :signature, :version, :avm_version, :size, :nbits,
                :xmax, :ymax, :width, :height,
                :frame_rate, :frame_count
    
    def initialize(file_path)
      @file       = file_path
      @compressed = false
      
      parse_header
    end
    
    def parse_header
      @size = read_full_size(@file)
      
      buffer = File.open(@file, "rb") { |file| file.read }
      
      if !swf?(buffer)
        raise RuntimeError, "The provided file does not appear to be an SWF.", caller
      else
        @signature = buffer[0,3]
      end
      
      #######
      # TODO: continue the serious cleanup
      #######
      
      if is_compressed?(buffer[0])
        buffer = SWFDecompressor.new.uncompress(buffer)
        
        @compressed = true
      end


      @version = buffer[3].ord
      @nbits = ((buffer[8].ord & 0xff) >> 3)
      
      pbo = read_packed_bits(buffer, 8, 5, @nbits)
      pbo2 = read_packed_bits(buffer, pbo.nextByteIndex,pbo.nextBitIndex, @nbits)
      pbo3 = read_packed_bits( buffer, pbo2.nextByteIndex,pbo2.nextBitIndex, @nbits)
      pbo4 = read_packed_bits( buffer, pbo3.nextByteIndex,pbo3.nextBitIndex, @nbits)
      
      @xmax = pbo2.value
      @ymax = pbo4.value 

      @width = convert_twips_to_pixels(@xmax)
      @height = convert_twips_to_pixels(@ymax)

      byte_pointer = pbo4.nextByteIndex + 2

      @frame_rate = buffer[byte_pointer].ord
      byte_pointer += 1
      
      fc1 = buffer[byte_pointer].ord & 0xFF
      byte_pointer += 1

      fc2 = buffer[byte_pointer].ord & 0xFF
      byte_pointer += 1
      
      @frame_count = (fc2 << 8) + fc1
      byte_pointer+=2
      
      avm_bit = buffer[byte_pointer].ord & 0x08
      
      @avm_version = (avm_bit == 0) ? "AVM1" : "AVM2"

      buffer=nil
    end
    
    def read_packed_bits(bytes,byte_marker,bit_marker,length)
      total = 0
      shift = 7 - bit_marker 
      counter = 0 
      bit_index = bit_marker 
      byte_index = byte_marker 
      
      while counter<length
        (bit_marker...8).each do |i|
          bit =((bytes[byte_marker].ord & 0xff ) >> shift ) & 1
          total = ( total << 1 ) + bit
          bit_index = i
          shift-=1
          counter+=1
          
          if counter==length
            break
          end
        end
      
        byte_index = byte_marker
        byte_marker+=1
        bit_marker = 0
        shift = 7
      end
      
      return PackedBitObj.new(bit_index, byte_index, total)
    end
    
    def convert_twips_to_pixels(twips)
      twips / 20
    end
    def convert_pixels_to_twips(pixels)
      return pixels * 20
    end
    
    def inspect
      "signature:    "+@signature.to_s+"\n"+
      "version:      "+@version.to_s+"\n"+
      "avm_version:  "+@avm_version.to_s+"\n"+
      "compressed?:  "+compressed?.to_s+"\n"+
      "size:         "+@size.to_s+"\n"+
      "nbits:        "+@nbits.to_s+"\n"+
      "xmax:         "+@xmax.to_s+"\n"+
      "ymax:         "+@ymax.to_s+"\n"+
      "width:        "+@width.to_s+"\n"+
      "height:       "+@height.to_s+"\n"+
      "frame_rate:   "+@frame_rate.to_s+"\n"+
      "frame_count:  "+@frame_count.to_s+"\n"
    end
    
    alias to_s inspect
    
    def compressed?
      @compressed
    end
    
    private
      def swf?(bytes)
        bytes[0,3] == 'FWS' or bytes[0,3] == 'CWS'
      end
  end
end