module Conversions
  def to_s
    "#{@file} #{@width}x#{@height} #{@frame_rate}fps"
  end
  
  def to_hash
    { :file         => @file,
      :signature    => @signature,
      :version      => @version,
      :avm_version  => @avm_version,
      :size         => @size,
      :bit_count    => @bit_count,
      :xmax         => @xmax,
      :ymax         => @ymax,
      :width        => @width,
      :height       => @height,
      :frame_rate   => @frame_rate,
      :frame_count  => @frame_count }
  end
  
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
end