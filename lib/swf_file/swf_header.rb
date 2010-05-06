class SwfHeader
  include Compression
  
  attr_reader :file, :signature, :version, :avm_version, :size, :bit_count,
              :xmax, :ymax, :width, :height,
              :frame_rate, :frame_count
  
  def initialize(swf_file)
    @file = swf_file
    parse_header
    parse_packed_bits
  end
  
  def compressed?(memoize_result = true)
    buffer_compressed?(memoize_result)
  end
  
  # Returns the duration in milliseconds
  def duration
    ((@frame_count / @frame_rate.to_f).round(5) * 1000).round
  end
  
  def to_s
    "#{@file} #{@width}x#{@height} #{@frame_rate}fps"
  end
  
  def to_hash
    Conversions::Hash.from_swf_header self
  end
  
  alias :inspect :to_hash
  
  private
    def parse_header
      @buffer, @size = get_swf_buffer_and_size
      raise RuntimeError, "The provided file does not appear to be an SWF", caller unless swf?
      
      @signature  = @buffer[0,3]
      @version    = @buffer[3].ord
      
      decompress_buffer! if compressed?

      @bit_count  = ((@buffer[8].ord & 0xff) >> 3)
    end
    
    def parse_packed_bits
      PackedBitObject.from_packed_bits(@buffer, 8, 5, @bit_count) do |pbo|
        
        PackedBitObject.from_packed_bits(@buffer, pbo.nextByteIndex, pbo.nextBitIndex, @bit_count) do |pbo2|
          @xmax = pbo2.value
          
          PackedBitObject.from_packed_bits(@buffer, pbo2.nextByteIndex, pbo2.nextBitIndex, @bit_count) do |pbo3|
            
            PackedBitObject.from_packed_bits(@buffer, pbo3.nextByteIndex, pbo3.nextBitIndex, @bit_count) do |pbo4|
              @ymax   = pbo4.value
              @width  = Conversions::Pixels.from_twips @xmax
              @height = Conversions::Pixels.from_twips @ymax
                            
              byte_pointer = pbo4.nextByteIndex + 2
              
              @frame_rate = @buffer[byte_pointer].ord
              byte_pointer += 1
              
              fc1 = @buffer[byte_pointer].ord & 0xFF
              byte_pointer += 1
              
              fc2 = @buffer[byte_pointer].ord & 0xFF
              byte_pointer += 1
              
              @frame_count = (fc2 << 8) + fc1
              byte_pointer+=2
              
              @avm_version = ((@buffer[byte_pointer].ord & 0x08) == 0) ? "AVM1" : "AVM2"
            end #pbo4
          end #pbo3
        end #pbo2
      end #pbo
    end
    
    def get_swf_buffer_and_size
      size = 0
      
      buffer = File.open(@file,"rb") do |file|
        file.seek(4, IO::SEEK_CUR)
        size = file.read(4).unpack("L")[0]
        
        file.rewind
        file.read
      end
      
      [buffer, size]
    end
    
    def swf?
      @buffer[0,3] == 'FWS' || @buffer[0,3] == 'CWS'
    end
end