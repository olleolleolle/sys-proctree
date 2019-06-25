$LOAD_PATH.push ::File.expand_path("lib", __dir__)
require "sys/proctree/version"

Gem::Specification.new do |spec|
  spec.name = "sys-proctree"
  spec.version = ::Sys::ProcTree::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = %w{ dueckes }
  spec.summary = "Discovers and can attempt to lay waste to a process tree"
  spec.description = "Discovers and kills process trees via analysing running process lists"
  spec.email = "matthew.ueckerman@myob.com"
  spec.homepage = "http://github.com/MYOB-Technology/sys-proctree"
  spec.rubyforge_project = "sys-proctree"
  spec.license = "MIT"

  spec.files        = Dir.glob("./lib/**/*")
  spec.test_files   = Dir.glob("./spec/**/*")

  spec.require_path = "lib"

  spec.required_ruby_version = ">= 2.3"

  spec.add_dependency "sys-proctable", "~> 1.2"

  spec.add_development_dependency "rake",        "~> 12.3"
  spec.add_development_dependency "rubocop",     "~> 0.71"
  spec.add_development_dependency "rspec",       "~> 3.8"
  spec.add_development_dependency "os",          "~> 0.9"
  spec.add_development_dependency "irb",         "~> 1.0"
  spec.add_development_dependency "simplecov",   "~> 0.16"
  spec.add_development_dependency "travis-lint", "~> 2.0"
end
