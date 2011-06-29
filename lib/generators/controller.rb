# encoding: UTF-8

module Merb::Generators
  class Controller < NamespacedGenerator

    include AppGeneratorHelpers

    source_root(template_base('component/controller'))

    desc 'Generate a new controller.'

    class_option_for :testing_framework
    class_option_for :template_engine

    def create_controller
      invoke Helper

      template 'app/controllers/%file_name%.rb', File.join("app/controllers", base_path, "#{file_name}.rb")
      template 'app/views/%file_name%/index.html.erb', File.join("app/views", base_path, "#{file_name}/index.html.erb")

      case testing_framework
      when :rspec
        template 'spec/requests/%file_name%_spec.rb', File.join("spec/requests", base_path, "#{file_name}_spec.rb")

      when :test_unit
        template 'test/requests/%file_name%_test.rb', File.join("test/requests", base_path, "#{file_name}_test.rb")
      end
    end

  end
end
