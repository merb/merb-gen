# encoding: UTF-8

module Merb::Generators
  class Model < NamespacedGenerator

    include AppGeneratorHelpers

    source_root(template_base('component/model'))

    desc <<-DESC
      Generates a new model. You can specify an ORM different from what the rest
      of the application uses.
    DESC

    class_option_for :testing_framework
    class_option_for :orm

    argument :attributes,
      :type => :hash,
      :default => {},
      :desc => "space separated model properties in form of name:type. Example: state:string"

    def create_model
      template 'app/models/%file_name%.rb.tt', File.join("app/models", base_path, "#{file_name}.rb")

      case testing_framework
      when :rspec
        template 'spec/models/%file_name%_spec.rb.tt', File.join("spec/models", base_path, "#{file_name}_spec.rb")

      when :test_unit
        template 'test/models/%file_name%_test.rb', File.join("test/models", base_path, "#{file_name}_test.rb")
      end
    end

    protected

    def attributes?
      self.attributes && !self.attributes.empty?
    end

    def attributes_for_accessor
      self.attributes.keys.map{|a| ":#{a}" }.compact.uniq.join(", ")
    end

  end
end
