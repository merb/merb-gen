# encoding: UTF-8

module Merb::Generators
  module GeneratorHelpers
    # Inside a template, wraps a block of code properly in modules,
    # keeping the indentation correct.
    #
    # @param [Array<#to_s>] modules Array of modules to use for nesting.
    # @param [Hash] options Additional options.
    # @option options [Integer] indent (0)
    #   Number of levels to indent the modules.
    def with_modules(modules, options={}, &block)
      indent = options[:indent] || 0

      text = capture(&block)

      modules.each_with_index do |mod, i|
        concat ("  " * (indent + i)) + "module #{mod}\n"
      end

      text = Array(text).map{ |line| ("  " * modules.size) + line }.join
      concat text

      modules.reverse.each_with_index do |mod, i|
        concat ("  " * (indent + modules.size - i - 1)) + "end # #{mod}\n"
      end
    end

    # Returns a string of num times `'..'`, useful for example in tests
    # for namespaced generators to find the `spec_helper` higher up in
    # the directory structure.
    #
    # @param [Integer] num Number of directories up.
    # @return [String] Concatenated string.
    def go_up(num)
      (["'..'"] * num).join(', ')
    end
  end

  module NamedGeneratorHelpers
    def class_name(_name = name)
      _name.gsub('-', '_').camelize
    end

    alias_method :module_name, :class_name

    def test_class_name
      class_name + "Test"
    end

    def file_name(_name = name)
      _name.underscore_preserve('-')
    end

    alias_method :base_name, :file_name

    def symbol_name
      file_name.gsub('-', '_')
    end
  end

  module AppGeneratorHelpers

    APP_DEFAULTS = {
      :template_engine => {
      :default => :erb,
      :desc => 'Template engine to prefer (one of: erb, haml).'
    },

      :testing_framework => {
      :default => :rspec,
      :desc => 'Testing framework to use (one of: rspec, test_unit).'
    },

      :orm => {
      :default => :none,
      :desc => 'Object-Relation Mapper to use (one of: none, activerecord, datamapper, sequel).'
    }
    }

    def self.included(base)
      base.extend ClassMethods
    end

    # Merb version.
    #
    # @return [String] Merb version.
    def merb_gems_version
      Merb::VERSION
    end

    # ORM gem dependencies.
    #
    # Adds ORM plugin dependency `'merb_#{orm}'` if we use any ORM.
    #
    # @param [Symbol] orm ORM to use.
    #
    # @return [String] Gem dependencies.
    def gems_for_orm(orm)
      orm.to_sym == :none ? '' : %Q{gem "merb_#{orm}"}
    end

    # Template enging gem dependencies.
    #
    # When using something else than erb we add merb plugin
    # dependency for the template engine.
    #
    # @param [Symbol] template_engine Template engine to use.
    #
    # @return [String] Gem dependencies.
    def gems_for_template_engine(template_engine)
      gems = ''
      if template_engine != :erb
        if [:haml, :builder].include? template_engine
          template_engine_plugin = "merb-#{template_engine}"
        else
          template_engine_plugin = "merb_#{template_engine}"
        end
        gems = %Q{gem "#{template_engine_plugin}"}
      end
      gems
    end

    # Testing framework gem dependencies.
    #
    # If we use any other test framework than RSpec we must add dependency
    # to the Gemfile. Merb depends on the RSpec so it's default dependency.
    #
    # @param [Symbol] test_framework Testing framework to use.
    #
    # @return [String] Gem dependencies.
    def gems_for_testing_framework(testing_framework)
      %Q{gem "#{testing_framework}", :group => :test}
    end

    def template_engine
      options[:template_engine].to_sym
    end

    def testing_framework
      options[:testing_framework].to_sym
    end

    def orm
      options[:orm].to_sym
    end

    module ClassMethods
      # Create a Thor class options for the default application parameters.
      #
      # @param [Symbol] s Application parameter to create
      # @param [Object] default Override for the default value
      def class_option_for(s, default=nil)
        raise "Unknown class option: #{s}" unless APP_DEFAULTS.has_key?(s)

        detail = APP_DEFAULTS[s]
        detail.merge({:default => default}) unless default.nil?

        class_option s, detail
      end

      # Create class options for all parameters in `APP_DEFAULTS`.
      #
      # @param [Hash] defaults Overrides for the default values.
      #
      # @example
      #   class MerbStack < AppGenerator
      #     app_class_options(:orm => :sequel)
      #
      #     # ...
      #   end
      def app_class_options(defaults = {})
        APP_DEFAULTS.keys.each do |k|
          class_option_for(k, defaults[k])
        end
      end
    end
  end

end
