require 'spec_helper'

describe Merb::Generators::Model do

  describe 'without a namespace' do
    describe "with rspec" do
      before :all do
        @generator = create_generator(Merb::Generators::Model, 'Stuff')
      end

      after_generator_spec

      it_should_behave_like "namespaced generator"

      it_should_generate

      it_should_create(
        'app/models/stuff.rb',
        'spec/models/stuff_spec.rb'
      )
    end

    describe "with test_unit" do
      before :all do
        @generator = create_generator(Merb::Generators::Model, 'Stuff', {:config => {:testing_framework => :test_unit }})
      end

      after_generator_spec

      it_should_generate

      it_should_create(
        'test/models/stuff_test.rb'
      )
    end
  end

  describe "with a namespace" do
    describe "with rspec" do
      before :all do
        @generator = create_generator(Merb::Generators::Model, 'John::Monkey::Stuff')
      end

      after_generator_spec

      it_should_generate

      it_should_create(
        'app/models/john/monkey/stuff.rb',
        'spec/models/john/monkey/stuff_spec.rb'
      )
    end

    describe "with test_unit" do
      before :all do
        @generator = create_generator(Merb::Generators::Model, 'John::Monkey::Stuff', {:config => {:testing_framework => :test_unit }})
      end

      after_generator_spec

      it_should_generate

      it_should_create(
        'test/models/john/monkey/stuff_test.rb'
      )
    end

  end

end
