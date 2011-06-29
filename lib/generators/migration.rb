# encoding: UTF-8

module Merb::Generators

  module MigrationHelpers
    def table_name
      self.name.underscore.pluralize
    end

    def class_name
      "#{self.name.camelize}Migration"
    end

    def migration_name
      self.name.underscore
    end

    def file_name
      "#{version}_#{migration_name}_migration"
    end

    def version
      # TODO: handle ActiveRecord timestamped migrations
      n = options[:delete] ? current_migration_nr : current_migration_nr + 1
      format("%03d", n)
    end

    def destination_directory
      File.join(destination_root, 'schema', 'migrations')
    end

    def current_migration_nr
      current_migration_number = Dir["#{destination_directory}/*"].map do |f|
        File.basename(f).match(/^(\d+)/)[0].to_i
      end.max.to_i
    end

  end

  #TODO: This is a no-op!
  class Migration < Generator
    include AppGeneratorHelpers
    include MigrationHelpers

    source_root(template_base('component/migration'))

    desc 'Generate a new database migration.'

    class_option_for :orm

    class_option :model,
      :type => :boolean,
      :desc => 'Specify this option to generate a migration which creates a table for the provided model'

    argument :name,
      :required => true

    argument :attributes,
      :type => :hash,
      :default => {}

  end
end
