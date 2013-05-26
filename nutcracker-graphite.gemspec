$:.unshift File.expand_path '../lib', __FILE__
require 'nutcracker/graphite/version'

Gem::Specification.new do |s|
  s.name                  = "nutcracker-graphite"
  s.version               = Nutcracker::Graphite::VERSION
  s.platform              = Gem::Platform::RUBY
  s.summary               = "Send Twemproxy/nutcracker statistics to Graphite"
  s.description           = "Nutcracker plugin for sending cluster statistics to Graphite"
  s.author                = "Eran Barak Levi"
  s.email                 = "eran@kontera.com"
  s.homepage              = 'http://www.kontera.com'
  s.required_ruby_version = '>= 1.8.5'
  s.rubyforge_project     = "ruby-nutcracker-graphite"
  s.files                 = %w(README.md Rakefile) + Dir.glob("{lib,tests}/**/*")
  s.require_path          = 'lib'

  s.add_runtime_dependency 'graphite-api', '~> 0.1.1'
  #s.add_runtime_dependency 'nutcracker',   '~> 0.2.4.3'
  s.add_runtime_dependency 'nutcracker',   '0.2.4.beta1'
  s.add_runtime_dependency 'redis'
  
  s.add_development_dependency 'minitest', '~> 5.0.0'
  s.add_development_dependency 'mocha',    '~> 0.14.0'

end
