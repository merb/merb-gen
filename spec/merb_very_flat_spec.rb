require 'spec_helper'

describe Merb::Generators::App::VeryFlat do

  describe "templates" do

    before :all do
      @generator = create_generator(Merb::Generators::App::VeryFlat, 'MerbFlat')
    end

    after_generator_spec

    it_should_behave_like "named generator"
    it_should_behave_like "app generator"

    it "should write to the supplied application path" do
      @generator.destination_root.should == app_path
    end

    it_should_generate

    describe "File creation" do
      it_should_create('Gemfile', 'bin/merb')

      it "should create a number of views"
    end

  end

end
