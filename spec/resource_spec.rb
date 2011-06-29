require 'spec_helper'

describe Merb::Generators::Resource do

  #FIXME
  pending "Specs need to be fixed" do
    before do
      @generator = create_generator(Merb::Generators::Resource, ['Project', {:name => :string }])
    end

    after_generator_spec

    it_should_generate

    it "should invoke the resource controller generator with the pluralized name" do
      @generator.should invoke(Merb::Generators::ResourceController).with('Projects', { :name => :string })
    end

    it "should invoke the model generator" do
      @generator.should invoke(Merb::Generators::ModelGenerator).with('Project', { :name => :string })
    end

  end # pending

end
