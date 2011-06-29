require 'spec_helper'

describe Merb::Generators::PartController do

  describe 'without a namespace' do
    before :all do
      @generator = create_generator(Merb::Generators::PartController, 'Stuff')
    end

    after_generator_spec

    it_should_behave_like "namespaced generator"

    it_should_generate

    it_should_create(
      'app/parts/stuff_part.rb',
      'app/parts/views/stuff_part/index.html.erb'
    )
  end

  describe "with a namespace" do
    before :all do
      @generator = create_generator(Merb::Generators::PartController, 'John::Monkey::Stuff')
    end

    after_generator_spec

    it_should_generate

    it_should_create(
      'app/parts/john/monkey/stuff_part.rb',
      'app/parts/views/john/monkey/stuff_part/index.html.erb'
    )
  end

end
