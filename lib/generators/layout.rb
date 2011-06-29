# encoding: UTF-8

module Merb::Generators
  class Layout < NamedGenerator

    include AppGeneratorHelpers

    source_root(template_base('component/layout'))

    desc 'Generate a new layout.'

    class_option_for :template_engine
    class_option_for :testing_framework

    def create_layout
      template 'app/views/layout/%file_name%.html.erb', "app/views/layout/#{file_name}.html.erb"
    end

  end
end
