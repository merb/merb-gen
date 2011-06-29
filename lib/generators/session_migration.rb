# encoding: UTF-8

module Merb::Generators

  #TODO: This is a no-op!
  class SessionMigration < Generator

    include AppGeneratorHelpers

    source_root(template_base('component/session_migration'))

    desc 'Generates a new session migration.'

    class_option_for :orm

    protected

    def version
      # TODO: handle ActiveRecord timestamped migrations
      format("%03d", current_migration_nr + 1)
    end

    def destination_directory
      File.join(destination_root, 'schema', 'migrations')
    end

    def current_migration_nr
      current_migration_number = Dir["#{destination_directory}/*"].map{|f| File.basename(f).match(/^(\d+)/)[0].to_i  }.max.to_i
    end

  end
end
