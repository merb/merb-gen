# encoding: UTF-8

module Merb
  module Generators
    module App
      class VeryFlat < AppGenerator

        source_paths << template_base('application/merb_very_flat')

        app_class_options

        register

        desc <<-DESC
      Generates a new very flat Merb application: the whole application
      in one file, similar to Sinatra or Camping.
        DESC

        def create_application
          template 'application.rbt', "#{base_name}.rb"

          directory (testing_framework == :rspec ? "spec" : "test")
        end

      end
    end
  end
end
