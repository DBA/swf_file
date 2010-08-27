require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

test_files_pattern = 'test/unit/swf_file_test.rb'
Rake::TestTask.new do |t|
  t.libs << '.' << 'lib' << 'test'
  t.pattern = test_files_pattern
  t.verbose = true
end

gemspec = eval(File.read('swf_file.gemspec'))
Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

desc "build the gem and release it to rubygems.org"
task :release => :gem do
  sh "gem push pkg/swf_file-#{gemspec.version}.gem"
  sh "rm -rf pkg/"
end

task :default => :test