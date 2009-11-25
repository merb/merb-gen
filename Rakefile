require 'rubygems'
require 'rake'

# Assume a typical dev checkout to fetch the current merb-core version
require File.expand_path('../../merb-core/lib/merb-core/version', __FILE__)

# Load this library's version information
require File.expand_path('../lib/merb-gen/version', __FILE__)

begin

  gem 'jeweler', '~> 1.4'
  require 'jeweler'

  Jeweler::Tasks.new do |gemspec|

    gemspec.version     = Merb::Generators::VERSION

    gemspec.name        = "merb-gen"
    gemspec.description = "Merb plugin containing useful code generators"
    gemspec.summary     = "Merb plugin that provides a suite of code generators for Merb."

    gemspec.authors     = [ "Jonas Nicklas" ]
    gemspec.email       = "jonas.nicklas@gmail.com"
    gemspec.homepage    = "http://merbivore.com/"

    gemspec.files       = %w(LICENSE Rakefile README TODO) + Dir['{bin,lib,spec}/**/*']

    # Runtime dependencies
    gemspec.add_dependency('merb-core', "~> #{Merb::VERSION}")
    gemspec.add_dependency "templater", ">= 1.0.0"

    # Development dependencies
    gemspec.add_development_dependency 'rspec', '>= 1.2.9'

    # Executable files
    gemspec.executables = 'merb-gen'

  end

  Jeweler::GemcutterTasks.new

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.spec_opts << '--options' << 'spec/spec.opts' if File.exists?('spec/spec.opts')
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "test_gem #{Merb::Generators::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
