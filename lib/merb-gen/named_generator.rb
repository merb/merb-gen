# encoding: UTF-8

require 'merb-gen/helpers/generator_helpers'

module Merb
  module Generators

    class NamedGenerator < Generator
      include NamedGeneratorHelpers

      argument :name, :required => true

      def initialize(*args)
        super
      end
    end

  end
end
