require 'lzma'
require 'xz'

module SwfFile

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
        Zlib::Inflate.new.inflate strip_buffer_header(_buffer)
      end

      def decompress_lzma(buffer)
        #XZ.decompress_file('output.lzma.xz','output.raw')
        XZ.decompress(strip_buffer_header(buffer))
        #LZMA.decompress(strip_buffer_header(buffer))
      end

      def decompress_buffer!
        return @buffer unless buffer_compressed?(false)

        _buffer = @buffer # local buffer copy
        _buffer = @compression == 'zlib' ? decompress_zlib(_buffer) : decompress_lzma(_buffer)
        _buffer = _buffer[0,8] + _buffer
        _buffer[0] = ?F

        @buffer = _buffer
      end

      def strip_buffer_header(buffer)
        buffer[8, buffer.size - 8]
      end

  end # Compression

end # SwfFile
