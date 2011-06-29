# encoding: UTF-8

module Merb::Generators
  module Dev
    class Plugin < NamedGenerator

      include AppGeneratorHelpers

      source_root(template_base('application/merb_plugin'))

      register

      def initialize(*args)
        Merb.disable(:initfile)

        _args, _options, _config = args
        droot = _config[:destination_root] || Dir.pwd

        #TODO: does this work? base_name might be uninitialised
        _config.merge({:destination_root => File.join(droot, base_name(_args[0]))})

        super(_args, _options, _config)
      end

      class_option_for :testing_framework
      class_option_for :orm

      class_option :bin,
        :type => :boolean,
        :desc => 'The plugin provides a binary.'

      desc 'Generates a new Merb plugin.'

      def create_merb_plugin
        copy_file 'TODO'

        template 'README'
        template 'LICENSE'
        template 'Rakefile'

        directory 'lib'
        directory 'bin' if options[:bin]
        directory (testing_framework == :rspec ? "spec" : "test")
      end

    end
  end
end
