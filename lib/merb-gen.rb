# encoding: UTF-8

require 'merb-core'

require 'digest/sha1'
require 'thor/group'

require 'merb-gen/helpers/generator_helpers'
require 'merb-gen/generator'
require 'merb-gen/named_generator'
require 'merb-gen/namespaced_generator'
require 'merb-gen/app_generator'

require 'merb-gen/core_ext/string'

require File.expand_path('../generators/merb/merb_stack',     __FILE__)
require File.expand_path('../generators/merb/merb_core',      __FILE__)
require File.expand_path('../generators/merb/merb_flat',      __FILE__)
require File.expand_path('../generators/merb/merb_very_flat', __FILE__)
require File.expand_path('../generators/merb_plugin',         __FILE__)
require File.expand_path('../generators/controller',          __FILE__)
require File.expand_path('../generators/helper',              __FILE__)
require File.expand_path('../generators/part_controller',     __FILE__)
require File.expand_path('../generators/migration',           __FILE__)
require File.expand_path('../generators/session_migration',   __FILE__)
require File.expand_path('../generators/model',               __FILE__)
require File.expand_path('../generators/resource_controller', __FILE__)
require File.expand_path('../generators/resource',            __FILE__)
require File.expand_path('../generators/layout',              __FILE__)
require File.expand_path('../generators/passenger',           __FILE__)
require File.expand_path('../generators/fcgi',                __FILE__)

Merb.generators.each do |file|
  require file
end
