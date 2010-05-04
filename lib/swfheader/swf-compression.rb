module SwfUtil
  class SWFCompression
    def read_full_size(file)
      buff=File.open(file,"rb") do |f|
        f.seek(4,IO::SEEK_CUR)
        f.read 4
      end
      buff.unpack("L")[0]
    end
    def strip_header(bytes)
      bytes[8,bytes.size-8]
    end
    def is_compressed?(first_byte)
      first_byte==?C
    end
  end
end

