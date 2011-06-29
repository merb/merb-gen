require 'spec_helper'

describe Merb::Generators::Layout do

  before :all do
    @generator = create_generator(Merb::Generators::Layout, 'Stuff')
  end

  after_generator_spec

  it_should_behave_like "named generator"

  it_should_generate

  it_should_create 'app/views/layout/stuff.html.erb'
  it "should create a view spec"

end
