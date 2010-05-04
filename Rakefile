require 'rake'
require 'bundler'
begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

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
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must install spicycode-rcov"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "swfutil #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :test => :check_dependencies
task :default => :test