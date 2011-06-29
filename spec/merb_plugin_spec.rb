require 'spec_helper'

describe Merb::Generators::Dev::Plugin do

  describe 'without the "bin" option' do
    describe "templates" do

      before :all do
        @generator = create_generator(Merb::Generators::Dev::Plugin, 'MerbPlugin')
      end

      after_generator_spec

      it_should_behave_like "named generator"

      it_should_generate

      it 'should not create a "bin" directory' do
        File.exist?(app_path('bin')).should be_false
      end

      it "should create a number of views"

    end
  end # without bin option

  describe 'with the "bin" option' do
    describe "templates" do

      before :all do
        @generator = create_generator(Merb::Generators::Dev::Plugin, 'CoolMerbPlugin', {:config => {:bin => true}})
      end

      after_generator_spec

      it_should_generate

      it_should_create 'bin/cool_merb_plugin'

      it "should create a number of views"

    end
  end # with bin option

end
