module SwfFile

  class PackedBitObject
    attr_accessor :bitIndex, :byteIndex, :value, :nextBitIndex, :nextByteIndex, :nextByteBoundary

    def initialize(bitMarker, byteMarker, decimalValue)
      @nextBitIndex = @bitIndex = bitMarker
      @byteIndex    = byteMarker
      @value        = decimalValue

      if bitMarker <= 7
        @nextBitIndex     += 1
        @nextByteIndex    = byteMarker
        @nextByteBoundary = byteMarker += 1
      else
        @nextBitIndex     = 0
        @nextByteIndex    +=1
        @nextByteBoundary = @nextByteIndex;
      end
    end

    def self.from_packed_bits(bytes, byte_marker, bit_marker, length)
      counter     = total = 0
      shift       = 7 - bit_marker
      bit_index   = bit_marker
      byte_index  = byte_marker

      while counter < length
        (bit_marker...8).each do |i|
          bit       = ((bytes[byte_marker].ord & 0xff ) >> shift) & 1
          total     = (total << 1) + bit
          bit_index = i
          shift     -= 1
          counter   += 1

          break if counter == length
        end

        byte_index  = byte_marker
        byte_marker +=1
        bit_marker  = 0
        shift       = 7
      end

      pbo = PackedBitObject.new(bit_index, byte_index, total)
      yield pbo if block_given?
      pbo
    end
  end # PackedBitObject

end # SwfFile
