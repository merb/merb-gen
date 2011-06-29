require 'spec_helper'

describe Merb::Generators::NamespacedGenerator do

  before(:each) do
    @generator = create_generator(Merb::Generators::NamespacedGenerator, 'Stuff')
  end

  after_generator_spec

  it_should_behave_like "namespaced generator"

end
