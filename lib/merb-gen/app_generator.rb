# encoding: UTF-8

module Merb
  module Generators

    class AppGenerator < NamedGenerator

      def initialize(*args)
        Merb.disable(:initfile)
        super
      end

      # Helper to get Merb version.
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

    end
  end
end
