$:.push File.expand_path("../lib", __FILE__)
require "routespec/version"

Gem::Specification.new do |s|
  s.name        = "routespec"
  s.version     = Routespec::VERSION
  s.authors     = ["SoAwesomeMan"]
  s.email       = ["callme@1800AWESO.ME"]
  s.homepage    = "http://www.windermeresolutions.com"
  s.summary     = "Programmatically writing tests for more preciseness seems like a good idea!"
  s.description = "RSpec test writing automation for request testing Rails routes exposed in config/routes.rb"

  s.executables = ['routespec']

  s.files = Dir['lib/**/*'] + Dir['bin/*'] + ["Rakefile", "README", "lib/routespec/routespec/support/.gitkeep", "lib/routespec/routespec/requests/.gitkeep"]
  s.test_files = Dir["test/**/*"]
end
