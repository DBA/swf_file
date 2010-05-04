module SwfUtil
  class PackedBitObj
    attr_accessor :bitIndex,:byteIndex,:value,:nextBitIndex,:nextByteIndex,:nextByteBoundary
    def initialize(bitMarker,byteMarker,decimalValue)
      @bitIndex = bitMarker;
      @byteIndex = byteMarker;
      @value = decimalValue;
      @nextBitIndex = bitMarker;
      if ( bitMarker <= 7 )
        @nextBitIndex+=1
        @nextByteIndex =byteMarker
        @nextByteBoundary = (byteMarker+=1)
      else
        @nextBitIndex = 0
        @nextByteIndex+=1
        @nextByteBoundary = @nextByteIndex;
      end
    end
  end
end