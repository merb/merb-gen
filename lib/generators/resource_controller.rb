# encoding: UTF-8

module Merb::Generators

  module ResourceControllerHelpers
    def model_class_name
      class_name.singularize
    end

    def plural_model
      class_name.underscore
    end

    def singular_model
      plural_model.singularize
    end

    def resource_path
      chunks.map{ |c| c.underscore }.join('/')
    end

    # TODO: fix this for Datamapper, so that it returns the primary keys for the model
    def params_for_get
      "params[:id]"
    end

    # TODO: implement this for Datamapper so that we get the model properties
    def properties
      []
    end

    def skip_route_definition?
      options[:pretend] || options[:delete]
    end
  end

  class ResourceController < NamespacedGenerator
    include AppGeneratorHelpers
    include ResourceControllerHelpers

    source_root(template_base('component/resource_controller'))

    desc 'Generate a new resource controller.'

    app_class_options

    argument :attributes,
      :type => :hash,
      :default => {},
      :desc => "space separated resource model properties in form of name:type. Example: state:string"

    def create_resource_controller
      invoke Helper

      case options[:orm]

      when :none
        directory 'app'
        directory (testing_framework == :rspec ? "spec" : "test")

      end # case ORM
    end

    def add_resource_route
      unless skip_route_definition?
        plural_resource = self.plural_model
        router_path = Merb.root + "/config/router.rb"
        sentinel = "Merb::Router.prepare do"
        to_inject = "resources :#{plural_resource}"

        if File.exist?(router_path)
          content = File.read(router_path).gsub(/(#{Regexp.escape(sentinel)})/mi){|match| "#{match}\n  #{to_inject}"}
          File.open(router_path, 'wb') { |file| file.write(content) }
        end
      end
    end

  end
end
