class SwfFile
  def initialize(swf_path)
    raise RuntimeError, "Must provide a valid SWF file path.", caller unless File.exists?(swf_path)
  end
end