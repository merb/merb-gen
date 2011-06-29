# encoding: UTF-8

module Merb::Generators
  class Passenger < Generator

    source_root(template_base('application/merb_stack'))

    desc 'Generates the configuration files needed to run Merb with Phusion Passenger.'

    def create_passenger
      copy_file 'config.ru'
    end

  end
end
