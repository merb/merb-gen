# encoding: UTF-8

module Merb::Generators
  class Resource < Generator

    include AppGeneratorHelpers

    desc 'Generate a new resource.'

    argument :name,
      :required => true,
      :desc => "resource name (singular)"

    argument :attributes,
      :type => :hash,
      :default => {},
      :desc => "space separated resource model properties in form of name:type. Example: state:string"

    class_option_for :testing_framework
    class_option_for :orm

    def create_resource
      invoke Model, model_name, attributes
      invoke ResourceController, controller_name, attributes

      shell.say "resources :#{model_name.pluralize.underscore} route added to config/router.rb"
    end

    protected

    def controller_name
      name.pluralize
    end

    def model_name
      name
    end

  end
end
