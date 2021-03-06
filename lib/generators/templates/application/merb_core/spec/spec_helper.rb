require "spec" # Satisfies Autotest and anyone else not using the Rake tasks
require "merb-core"

# this loads all plugins required in your init file so don't add them
# here again, Merb will do it for you
Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
  # You don't need this if you don't use Webrat directly in your specs
  config.include(Merb::Test::WebratHelper)
end
