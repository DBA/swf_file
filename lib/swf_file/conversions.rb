module Conversions
  module Twips
    def self.from_pixels(pixels)
      pixels * 20
    end
  end
  
  module Pixels
    def self.from_twips(twips)
      twips / 20
    end
  end
  
  module Hash
    def self.from_swf_header(header)
      { file: header.file,
        signature:    header.signature,
        version:      header.version,
        avm_version:  header.avm_version,
        size:         header.size,
        bit_count:    header.bit_count,
        xmax:         header.xmax,
        ymax:         header.ymax,
        width:        header.width,
        height:       header.height,
        frame_rate:   header.frame_rate,
        frame_count:  header.frame_count }
    end
  end
end