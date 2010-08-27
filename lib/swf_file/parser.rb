module SwfFile

  module Parser

    private
      def parse_header
        @buffer, @size = get_swf_buffer_and_size
        raise RuntimeError, "The provided file does not appear to be an SWF", caller unless swf?

        @signature  = @buffer[0,3]
        @version    = @buffer[3].ord

        decompress_buffer! if compressed?

        @bit_count  = ((@buffer[8].ord & 0xff) >> 3)
      end # parse_header

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
      end # parse_packed_bits

  end # Parser

end # SwfFile
