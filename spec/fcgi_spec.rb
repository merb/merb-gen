require 'spec_helper'

describe Merb::Generators::Fcgi do
  before :all do
    @generator = create_generator(Merb::Generators::Fcgi, temp_app_name)
  end

  after_generator_spec

  it_should_generate

  it_should_create(
    'public/.htaccess',
    'public/merb.fcgi'
  )
end
