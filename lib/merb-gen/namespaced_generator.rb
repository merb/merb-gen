# encoding: UTF-8

module Merb
  module Generators

    class NamespacedGenerator < NamedGenerator
      def modules
        chunks[0..-2]
      end

      def class_name
        chunks.last.gsub('-', '_').camelize
      end

      alias_method :module_name, :class_name

      def file_name
        chunks.last.underscore_preserve('-')
      end

      alias_method :base_name, :file_name

      def full_class_name
        (modules + [class_name]).join('::')
      end

      def base_path
        File.join(*snake_cased_chunks[0..-2])
      end

      def base_path_with_name
        File.join(base_path, file_name)
      end

      protected

      def snake_cased_chunks
        chunks.map { |c| c.underscore }
      end

      def chunks
        name.gsub('/', '::').split('::').map { |c| c.camelize }
      end

    end

  end
end
