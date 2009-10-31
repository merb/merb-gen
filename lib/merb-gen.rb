require 'merb-core'
require 'digest/sha1'
require 'templater'

require 'merb-gen/templater'
require 'merb-gen/generator'
require 'merb-gen/named_generator'
require 'merb-gen/namespaced_generator'
require 'merb-gen/app_generator'
require 'generators/merb/merb_stack'
require 'generators/merb/merb_core'
require 'generators/merb/merb_flat'
require 'generators/merb/merb_very_flat'
require 'generators/merb_plugin'
require 'generators/controller'
require 'generators/helper'
require 'generators/part_controller'
require 'generators/migration'
require 'generators/session_migration'
require 'generators/model'
require 'generators/resource_controller'
require 'generators/resource'
require 'generators/layout'
require 'generators/passenger'
require 'generators/fcgi'

Templater::Discovery.discover!('merb-gen')

Merb.generators.each do |file|
  require file
end
