require 'spec_helper'

module Merb::Test
  class GeneratorSpecGenerator < Merb::Generators::Generator
    source_paths << File.expand_path('fixtures', File.dirname(__FILE__))

    def create_with_modules_spec
      template 'templates/no_modules.test'
      template 'templates/some_modules.test'
    end
  end
end

describe Merb::Generators::Generator do
  before :all do
    @generator = create_generator(Merb::Test::GeneratorSpecGenerator, temp_app_name)
  end

  after_generator_spec

  it_should_generate :create_with_modules_spec

  describe "#go_up" do
    it "should output an empty string for argument 0" do
      @generator.go_up(0).should == ""
    end

    it "should output a single '..' for argument 1" do
      @generator.go_up(1).should == "'..'"
    end

    it "should concatenate multiple '..' for other arguments" do
      @generator.go_up(3).should == "'..', '..', '..'"
    end
  end

  describe "#with_modules" do
    it_should_create(
      'templates/no_modules.test',
      'templates/some_modules.test'
    )

    it "should be correct for no module" do
      File.read(app_path('templates/no_modules.test')).should == File.read(File.expand_path('fixtures/results/no_modules.test', File.dirname(__FILE__)))
    end

    it "should be correct for some module" do
      File.read(app_path('templates/some_modules.test')).should == File.read(File.expand_path('fixtures/results/some_modules.test', File.dirname(__FILE__)))
    end
  end

end
