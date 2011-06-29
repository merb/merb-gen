# encoding: UTF-8

require 'merb-gen/version'

module Merb
  module Generators
    module App
      class Stack < AppGenerator

        source_paths << template_base('application/merb_stack')

        app_class_options

        desc 'Generates a new "jump start" Merb application with support for DataMapper, ' +
          'helpers, assets, mailer, caching, slices and merb-auth.'

        register

        def create_application
          empty_directory 'lib/tasks'

          copy_file 'config.ru'

          directory 'app'
          directory 'autotest'
          directory 'config'
          directory 'doc'
          directory 'public'
          directory (testing_framework == :rspec ? "spec" : "test")

          invoke Layout
        end

        protected

        def dm_gems_version
          Merb::Generators::DM_VERSION_REQUIREMENT
        end

        def do_gems_version
          Merb::Generators::DO_VERSION_REQUIREMENT
        end

        def merb_auth_gems_version
          Merb::Generators::AUTH_VERSION_REQUIREMENT
        end

      end
    end
  end
end
