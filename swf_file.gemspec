# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY

  s.name        = "swf_file"
  s.version     = '1.1.1'
  s.summary     = "SWF File is lightweight gem to read swf file headers from within a Ruby application."

  s.authors     = ["Joshua Ostrom"]
  s.email       = ["joshuaostrom@gmail.com"]
  s.homepage    = "https://github.com/joshuaostrom/swf_file"

  s.description = "Fork of SWF File by Diogo Almeida to include support for LZMA compressed SWFs"

  s.required_rubygems_version = ">= 1.3.7"

  s.add_development_dependency('shoulda')
  s.add_runtime_dependency('ruby-lzma')

  s.files             = Dir.glob("{lib}/**/*") + %w(LICENSE README.rdoc)

  s.extra_rdoc_files  = %w(LICENSE README.rdoc)

  s.require_path = 'lib'
end
