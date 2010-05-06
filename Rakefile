require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "swf_file"
    gemspec.summary = "SWF File is lightweight gem to read swf file headers from within a Ruby application"
    gemspec.description = "Based on the swfutil lib, by Dennis Zhuang, the SWF File is lightweight gem to read swf file headers from within a Ruby application. This gem is fully written in Ruby and is compatible with Ruby v1.9.x"
    gemspec.email = "dba@gnomeslab.com"
    gemspec.homepage = "http://github.com/DBA/swf_file"
    gemspec.authors = ["DBA"]

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

task :default => :test