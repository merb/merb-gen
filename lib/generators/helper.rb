# encoding: UTF-8

module Merb::Generators
  class Helper < NamespacedGenerator

    include AppGeneratorHelpers

    source_root(template_base('component/helper'))

    desc 'Generates a new helper.'

    class_option_for :testing_framework

    def create_helper
      template 'app/helpers/%file_name%_helper.rb', File.join('app/helpers', base_path, "#{file_name}_helper.rb")
    end

  end
end
