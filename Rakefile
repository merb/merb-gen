require 'rubygems'
require 'rake'

# Load this library's version information
require File.expand_path('../lib/merb-gen/version', __FILE__)

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
  spec.fail_on_error = false
  spec.rcov = true
end

task :default => :spec

task :doc => [:yard]
begin
  require 'yard'

  YARD::Rake::YardocTask.new do |t|
    t.files   = [File.join('lib', '**', '*.rb'), '-', File.join('docs', '*.mkd')]
    t.options = [
      '--output-dir', 'doc/yard',
      '--tag', 'overridable:Overridable',
      '--markup', 'markdown',
      '--exclude', '/generators/'
    ]
  end
rescue
end
