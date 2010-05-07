$:.unshift(File.join(File.dirname(__FILE__), '../', '../', 'test'))

require 'test_helper'

class SwfFileTest < Test::Unit::TestCase

  context "SwfFile" do
    context "instance methods" do
      should "not be initializable without an SWF file path" do
        assert_raise(ArgumentError) { SwfFile.new }
      end
    
      should "raise an error if an invalid path is provided" do
        assert_raise(RuntimeError) { SwfFile.new "/path_to_imaginary_file" }
      end
      
      should "return a header with the regular properties" do
        swf = SwfFile.new fixture_path('clicktag.swf')
        assert_equal SwfHeader, swf.header.class
        assert_equal 4156, swf.header.size
        assert_equal swf.compressed?, swf.header.compressed?
      end
    end # instance methods
    
    context "class method header" do      
      should "raise an error when not provided with an SWF" do
        assert_raise(RuntimeError) { SwfFile.header fixture_path('smallgoat.jpg') }
      end
      
      setup do
        @header = SwfFile.header fixture_path('clicktag.swf')
      end
      
      should "return an instance of SwfHeader" do
        assert_equal SwfHeader, @header.class
      end
      
      should "indicate the file's size" do
        assert_equal 4156, @header.size
      end
      
      should "state if the swf was originally compressed" do
        assert @header.compressed?
        assert !SwfFile.header(fixture_path('clicktag-decompressed.swf')).compressed?
      end
      
      should "not make available private compression module methods" do
        %w{ :buffer_compressed? :strip_buffer_header :decompress_buffer! }.each do |method|
          assert !@header.respond_to?(method)
        end
      end
      
      should "state if its buffer is currently compressed" do
        assert @header.compressed?
        assert !@header.compressed?(false)
      end
      
      should "have the version" do
        assert_equal 8, @header.version
      end
      
      should "have the bit count" do
        assert_equal 15, @header.bit_count
      end
      
      should "have the xmax and ymax values" do
        assert_equal 9360, @header.xmax
        assert_equal 1200, @header.ymax
      end
      
      should "have the width and height values" do
        assert_equal 468, @header.width
        assert_equal 60, @header.height
      end
      
      should "have the frame rate and frame count" do
        assert_equal 24, @header.frame_rate
        assert_equal 1, @header.frame_count
      end
      
      should "include the duration of the swf file" do
        assert_equal 42, @header.duration
      end
      
      should "contain the avm version" do
        assert_equal 'AVM1', @header.avm_version
      end
      
      should "include the swf signature" do
        assert_equal 'CWS', @header.signature
      end
      
      should "output basing information when to_s is invoked" do
        assert @header.to_s =~ /.+clicktag.swf\s\d+x\d+\s\d\dfps/
      end
      
      should "be have a hash converter" do
        assert_equal Hash, @header.to_hash.class
      end
      
      should "have the same output for the instance methods inspect and to_hash" do
        assert_equal @header.to_hash, @header.inspect
      end
      
    end # SWF operations context
    
  end # SwfFile context
end # SwfFileTest