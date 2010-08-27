# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY

  s.name        = "swf_file"
  s.version     = '1.1.0.rc.2'
  s.summary     = "SWF File is lightweight gem to read swf file headers from within a Ruby application."

  s.authors     = ["Diogo Almeida"]
  s.email       = ["dba@gnomeslab.com"]
  s.homepage    = "http://github.com/DBA/swf_file/"

  s.description = "Based on the swfutil lib, by Dennis Zhuang, the SWF File is lightweight gem to read swf file headers from within a Ruby application. This gem is fully written in Ruby and is compatible with Ruby v1.8.7 through v1.9.2."

  s.required_rubygems_version = ">= 1.3.7"

  s.add_development_dependency('shoulda')

  s.files             = Dir.glob("{lib}/**/*") + %w(LICENSE README.rdoc)

  s.extra_rdoc_files  = %w(LICENSE README.rdoc)

  s.require_path = 'lib'
end
