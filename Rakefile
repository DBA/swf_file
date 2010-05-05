require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "swfheader"
    gemspec.summary = "SWF headers reader, along with SWF compression and decompression."
    gemspec.description = "Based on the now outdated Dennis Zhuang's original swfheader gem, this version provides you a Ruby API to read SWF file headers. Also supported is SWF file compression and decompression. Please note that this gem targets Ruby v1.9.2dev, while supporting versions 1.9.1 and 1.8.7."
    gemspec.email = "dba@gnomeslab.com"
    gemspec.homepage = "http://github.com/DBA/swfheader"
    gemspec.authors = ["DBA", "Dennis Zhuang"]

    # dependencies defined in Gemfile
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
#test_files_pattern = 'test/{unit,functional,other,matchers}/**/*_test.rb'
test_files_pattern = 'test/unit/swf_file_test.rb'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = test_files_pattern
  t.verbose = true
end