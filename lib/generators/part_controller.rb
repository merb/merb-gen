# encoding: UTF-8

module Merb::Generators
  class PartController < NamespacedGenerator

    source_root(template_base('component/part_controller'))

    desc 'Generate a new part controller.'

    def create_part_controller
      invoke Helper, ["#{full_class_name}Part"]

      template 'app/parts/%file_name%_part.rb.tt', File.join("app/parts", base_path, "#{file_name}_part.rb")
      template 'app/parts/views/%file_name%_part/index.html.erb.tt', File.join("app/parts/views", base_path, "#{file_name}_part/index.html.erb")
    end

  end
end
