module Merb::Generators

  class MerbFullGenerator < NamedGenerator

    def self.source_root
      File.join(super, 'application', 'merb')
    end

    option :testing_framework, :default => :rspec,
                               :desc => 'Testing framework to use (one of: rspec, test_unit).'
    option :orm, :default => :none,
                 :desc => 'Object-Relation Mapper to use (one of: none, activerecord, datamapper, sequel).'
    option :template_engine, :default => :erb,
                :desc => 'Template engine to prefer for this application (one of: erb, haml).'

    desc <<-DESC
      This generates a Merb application with Ruby on Rails like structure.
      Generator lets you configure your ORM and testing framework of choice.
    DESC

    template :gitignore do |template|
      template.source = File.join(common_templates_dir, 'dotgitignore')
      template.destination = ".gitignore"
    end

    glob!

    empty_directory :gems, 'gems'

    first_argument :name, :required => true, :desc => "Application name"

    invoke :layout do |generator|
      generator.new(destination_root, options, 'application')
    end

    def destination_root
      File.join(@destination_root, base_name)
    end

    def common_templates_dir
      File.expand_path(File.join(File.dirname(__FILE__), '..',
                      'templates', 'application', 'common'))
    end

  end

  add_private :app_full, MerbFullGenerator

end
