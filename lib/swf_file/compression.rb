module Compression
  private
    def buffer_compressed?(memoize_result = true)
      if memoize_result
        @compressed ||= @buffer[0].ord == ?C.ord
      else
        @compressed = @buffer[0].ord == ?C.ord
      end
    end

    def decompress_buffer!
      return @buffer unless buffer_compressed?(false)
      
      _buffer = @buffer # local buffer copy
      _buffer = Zlib::Inflate.new.inflate strip_buffer_header(_buffer)
      _buffer = _buffer[0,8] + _buffer
      _buffer[0] = ?F
      
      @buffer = _buffer
    end
    
    def strip_buffer_header(buffer)
      buffer[8, buffer.size - 8]
    end
end