$:.unshift File.expand_path '../lib', __FILE__
require 'nutcracker/graphite'
require 'rubygems/package_task'
require 'rake/testtask'

Nutcracker::GemSpec = eval File.read 'nutcracker-graphite.gemspec'

Gem::PackageTask.new Nutcracker::GemSpec do |p|
  p.gem_spec = Nutcracker::GemSpec
end

## Tests stuff
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.libs.push 'tests'
  t.pattern = 'tests/**/*_test.rb'
end
