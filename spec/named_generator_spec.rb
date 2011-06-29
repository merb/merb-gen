require 'spec_helper'

describe Merb::Generators::NamedGenerator do

  before(:each) do
    @generator = create_generator(Merb::Generators::NamedGenerator, 'Stuff')
  end

  after_generator_spec

  it_should_behave_like "named generator"

end
