require 'cover_me'

require_relative "../lib/sys/proctree"
Bundler.require(:test)

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file }
