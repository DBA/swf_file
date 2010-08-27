module SwfFile

  class SwfHeader
    include Parser
    include Compression
    include Conversions
    include Assertions

    attr_reader :file, :signature, :version, :avm_version, :size, :bit_count,
      :xmax, :ymax, :width, :height,
      :frame_rate, :frame_count

    def initialize(swf_file)
      @file = swf_file
      parse_header
      parse_packed_bits
    end

    # Returns the duration in milliseconds
    # The formula used in this method used to be +((@frame_count / @frame_rate.to_f).round(5) * 1000).round+.
    # This however, was not compatible with ruby 1.8, thus reverted to its current form.
    def duration
      ((@frame_count / @frame_rate.to_f * 10**5).round.to_f / 10**5 * 1000).round
    end

    alias :inspect :to_hash

    private
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
  end # SwfHeader

end # SwfFile
