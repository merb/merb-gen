require 'spec_helper'

describe Merb::Generators::Controller do

  describe "Without a namespace" do
    describe "with rspec" do
      before :all do
        @generator = create_generator(Merb::Generators::Controller, 'Stuff')
      end

      after_generator_spec

      it_should_behave_like "namespaced generator"

      it_should_generate

      describe 'File creation' do
        it_should_create(
          'app/controllers/stuff.rb',
          'app/views/stuff/index.html.erb'
        )

        it_should_create 'spec/requests/stuff_spec.rb'
      end
    end # with rspec

    describe "with test_unit" do
      before :all do
        @generator = create_generator(
          Merb::Generators::Controller, 'Stuff',
          {:config => {:testing_framework => :test_unit}}
        )
      end

      after_generator_spec

      it_should_generate

      it_should_create 'test/requests/stuff_test.rb'
    end # with test_unit

  end # without namespace

  describe "with a namespace" do
    describe "with rspec" do
      before :all do
        @generator = create_generator(Merb::Generators::Controller, 'John::Monkey::Stuff')
      end

      it_should_generate

      describe 'File creation' do
        it_should_create(
          'app/controllers/john/monkey/stuff.rb',
          'app/views/john/monkey/stuff/index.html.erb',
          'app/helpers/john/monkey/stuff_helper.rb'
        )

        it_should_create 'spec/requests/john/monkey/stuff_spec.rb'
      end
    end # with rspec

    describe "with test_unit" do
      before :all do
        @generator = create_generator(
          Merb::Generators::Controller,
          'John::Monkey::Stuff',
          {:config => { :testing_framework => :test_unit }}
        )
      end

      after_generator_spec

      it_should_generate
    end # with test_unit

  end # with namespace
end
