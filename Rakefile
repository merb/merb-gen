require 'rubygems'
require 'rake'

# Load this library's version information
require File.expand_path('../lib/merb-gen/version', __FILE__)

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
