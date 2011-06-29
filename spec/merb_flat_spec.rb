require 'spec_helper'

describe Merb::Generators::App::Flat do

  describe "templates" do

    before :all do
      @generator = create_generator(Merb::Generators::App::Flat, 'MerbFlat')
    end

    after_generator_spec

    it_should_generate

    it_should_behave_like "named generator"
    it_should_behave_like "app generator"

    describe "file generation" do
      it_should_create(
        'Gemfile', 'bin/merb'
      )

      it "should create a number of views"
    end

  end
end
