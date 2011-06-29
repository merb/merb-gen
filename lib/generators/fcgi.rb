# encoding: UTF-8

module Merb::Generators
  class Fcgi < Generator

    source_root(template_base('component/fcgi'))

    desc 'Generate the configuration files needed to run Merb with FastCGI.'

    def create_fcgi
      copy_file 'dothtaccess', File.join('public', '.htaccess')
      copy_file 'merb.fcgi', File.join('public', 'merb.fcgi')
    end
  end
end
