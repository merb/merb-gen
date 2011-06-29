# encoding: UTF-8

module Merb
  module Generators
    module App
      class Core < AppGenerator

        source_paths << template_base('application/merb_core')

        app_class_options

        register

        desc <<-DESC
      Generates a new Merb application with Ruby on Rails like structure.
      You can specify the ORM and testing framework.
        DESC

        def create_application
          empty_directory 'lib/tasks'

          directory 'app'
          directory 'autotest'
          directory 'config'
          directory 'doc'
          directory 'public'
          directory (testing_framework == :rspec ? "spec" : "test")

          invoke Layout
        end

      end
    end
  end
end
