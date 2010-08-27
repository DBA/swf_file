module SwfFile

  class FlashFile
    # Class methods
    def self.header(swf_path)
      raise RuntimeError, "SWF file not found.", caller unless File.exists?(swf_path)

      header = SwfHeader.new(swf_path)
      yield(header) if block_given?
      header
    end

    # Instance methods
    def initialize(swf_path)
      raise RuntimeError, "SWF file not found.", caller unless File.exists?(swf_path)

      @header = SwfHeader.new(swf_path)
    end

    def header
      yield(@header) if block_given?
      @header
    end

    def compressed?
      @header.compressed?
    end
  end # FlashFile

end # SwfFile
