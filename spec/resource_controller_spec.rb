require 'spec_helper'

describe Merb::Generators::ResourceController do

  describe 'without a namespace' do
    before :all do
      @generator = create_generator(Merb::Generators::ResourceController, 'Stuff')
    end

    after_generator_spec

    it_should_behave_like "namespaced generator"

    describe "#model_class_name" do
      it "should camel case and singularize the controller name" do
        @generator.name = "project_pictures"
        @generator.model_class_name == "ProjectPicture"
      end
    end

    describe "#plural_model" do
      it "should snake case the controller name" do
        @generator.name = "ProjectPictures"
        @generator.plural_model == "project_pictures"
      end
    end

    describe "#singular_model" do
      it "should snake case and singularize the controller name" do
        @generator.name = "ProjectPictures"
        @generator.singular_model == "project_picture"
      end
    end

    describe "#resource_path" do
      it "should snake case and slash separate the full controller name" do
        @generator.name = "Monkey::BlahWorld::ProjectPictures"
        @generator.singular_model == "monkey/blah_world/project_picture"
      end
    end

    it_should_generate

    describe 'controller generation' do
      it_should_create 'app/controllers/stuff.rb'
    end

    describe 'view generation' do
      it_should_create(
        'app/views/stuff/index.html.erb',
        'app/views/stuff/new.html.erb',
        'app/views/stuff/edit.html.erb',
        'app/views/stuff/show.html.erb'
      )
    end

    describe 'helper generation' do
      it_should_create 'app/helpers/stuff_helper.rb'
    end

  end # without a namespace

  describe "with a namespace" do

    before :all do
      @generator = create_generator(Merb::Generators::ResourceController, 'John::Monkey::Stuff')
    end

    after_generator_spec

    it_should_generate

    describe 'controller generation' do
      it_should_create 'app/controllers/john/monkey/stuff.rb'
    end

    describe 'view generation' do
      it_should_create(
        'app/views/john/monkey/stuff/index.html.erb',
        'app/views/john/monkey/stuff/new.html.erb',
        'app/views/john/monkey/stuff/edit.html.erb',
        'app/views/john/monkey/stuff/show.html.erb'
      )
    end

    describe 'helper generation' do
      it_should_create 'app/helpers/john/monkey/stuff_helper.rb'
    end

  end # with a namespace

end
