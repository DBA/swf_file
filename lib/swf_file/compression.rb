require 'lzma'
module SwfFile



#ZWS SWF Header
#
#ZWS + Version   Uncompressed Length     Compressed Length       LZMA Properties     Compressed Data
#[0][1][2][3]       [4][5][6][7]          [8][9][10][11]       [12][13][14][15][16]       [17][n]   
#
#Standard LZMA Header (13 bytes)
#
#LZMA Properties        Uncompressed Length      Compressed Data
#[0][1][2][3][4]    [5][6][7][8][9][10][11][12]      [13][n]


  module Compression

    private
      def buffer_compressed?(memoize_result = true)
        if memoize_result
          @compressed ||= @buffer[0].ord == ?C.ord
          @compression ||= @buffer[0].ord == ?C.ord ? 'zlib' : @buffer[0].ord == ?Z.ord ? 'lzma' : nil
        else
          @compressed = @buffer[0].ord == ?C.ord
          @compression ||= @buffer[0].ord == ?C.ord ? 'zlib' : @buffer[0].ord == ?Z.ord ? 'lzma' : nil
        end
      end

      def decompress_zlib(buffer)
        Zlib::Inflate.new.inflate strip_buffer_header(buffer,8)
      end

      def decompress_lzma(buffer)
        # LZMA format is lzma_properties (5 bytes) 
        # followed by uncompressed size (64 bit) 
        # followed by compressed data
        len = buffer[4..7].unpack('V').first - 8 
        lzma_props = buffer[12..16]
        compressed_data = buffer[17,buffer.size-17]
        LZMA.decompress(lzma_props << [len].pack("Q") << compressed_data)
      end

      def decompress_buffer!
        return @buffer unless buffer_compressed?(false)

        _buffer = @buffer # local buffer copy
        _buffer = @compression == 'zlib' ? decompress_zlib(_buffer) : decompress_lzma(_buffer)
        _buffer = _buffer[0,8] + _buffer
        _buffer[0] = ?F

        @buffer = _buffer
      end

      def strip_buffer_header(buffer,size)
        buffer[size, buffer.size - size]
      end

  end # Compression

end # SwfFile
