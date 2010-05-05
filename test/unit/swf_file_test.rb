require_relative '../test_helper'

class SwfFileTest < Test::Unit::TestCase

  context "SwfFile" do
    context "Initialization" do
      should "not be initializable without an SWF file path" do
        assert_raise(ArgumentError) { SwfFile.new }
      end
    
      should "raise an error if an invalid path is provided" do
        assert_raise(RuntimeError) { SwfFile.new "/path_to_imaginary_file" }
      end
    end # Initialization context
    
    context "SWF file operations" do
      setup do
        @swf = fixture_path 'clicktag.swf'
      end
      
      should "provide a headers hash" do
        assert Hash, @swf.headers.class
      end
    end # SWF operations context
    
  end # SwfFile context
end # SwfFileTest