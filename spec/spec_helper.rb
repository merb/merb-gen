require "rubygems"

# Use current merb-core sources if running from a typical dev checkout.
lib = File.expand_path('../../../merb-core/lib', __FILE__)
$LOAD_PATH.unshift(lib) if File.directory?(lib)
require 'merb-core'

# The lib under test
require "merb-gen"

# Satisfies Autotest and anyone else not using the Rake tasks
require 'rspec'

Merb.disable(:initfile)

require 'tmpdir'

module Merb
  module Test
    class SpecThorShell < Thor::Shell::Basic
      Answers = {}

      def initialize(answers = {})
        Answers.merge!(answers)
      end

      # Map questions to entries in Answers.
      #
      # This covers #yes? and #no?
      def ask(statement, color=nil)
        raise ArgumentError.new("Expected a stored answer for statement #{statement.inspect}") unless Answers.has_key?(statement)
        Answers[statement]
      end

      def error(statement)
      end

      # Always overwrite files.
      def file_collision(destination)
        true
      end

      def print_table(*args)
      end

      def print_wrapped(*args)
      end

      def say(*args)
      end

      def say_status(*args)
      end
    end

    module AppGenerationHelpers

      def app_path(*frags)
        File.join(@app_base_dir, *frags)
      end

      def app_name
        @app_name
      end

      def temp_app_name
        "Temp#{Process.pid}"
      end

      # Build generator writing to temporary path.
      #
      # You can pass a `:config` key in options which will be used as the
      # `config` parameter to the Generator. By default, created generators
      # will use a SpecThorShell instance which mutes all output and does
      # not reply to questions. If you need to test a generator which
      # depends on user input, pass an instance with the proper answers
      # as the `:shell` option.
      def create_generator(klass, name, options={})
        raise "Will not create a new generator, already using one with temp dir #{@app_spec_base_dir}" unless @app_spec_base_dir.nil?

        dir = Dir.mktmpdir

        @app_name = name.is_a?(Array) ? name.first : name
        @app_spec_base_dir = dir
        @app_base_dir = File.join(@app_spec_base_dir, @app_name)

        config = options.delete(:config) || {}
        options[:shell] ||= SpecThorShell.new

        klass.new(name.is_a?(Array) ? name : [name], config, {:destination_root => @app_base_dir}.merge(options))
      end

      def after_generator_spec(_when = :all)
        after _when do
          FileUtils.remove_entry_secure @app_spec_base_dir unless @app_spec_base_dir.nil?
          @app_spec_base_dir = nil
        end
      end

      # Call before specs depending on generated content.
      #
      # Runs the generator to a temporary directory, creating all files.
      def it_should_generate(_which = nil)
        it "should create the application" do
          lambda do
            if _which.nil?
              @generator.invoke_all
            else
              @generator.invoke _which
            end
          end.should_not raise_error
        end
      end

      # Check file generation.
      #
      # @param [String*] files Paths to check for existence. Relative to the
      #   generator root.
      def it_should_create(*files)
        files.each do |fname|
          it "should create #{fname}" do
            File.exist?(app_path(fname)).should be_true
          end
        end
      end

    end
  end
end

RSpec.configure do |config|
  include Merb::Test::AppGenerationHelpers
end

shared_examples_for "app generator" do

  describe "#gems_for_orm" do
    [:activerecord, :sequel, :datamapper].each do |orm|
      it "should generate DSL for #{orm} ORM plugin" do
        @generator.gems_for_orm(orm).should == %Q{gem "merb_#{orm}"}
      end
    end

    it "should not generate DSL if we don't use ORM" do
      @generator.gems_for_orm(:none).should  == ''
    end
  end

  describe "#gems_for_template_engine" do
    [:haml, :builder].each do |engine|
      it "should generate DSL for #{engine} template engine plugin" do
        @generator.gems_for_template_engine(engine).should == %Q{gem "merb-#{engine}"}
      end
    end

    it "should generate DSL for template engine plugins other than haml and builder" do
      @generator.gems_for_template_engine(:liquid).should == 'gem "merb_liquid"'
    end

    it "should not generate DSL if we use erb" do
      @generator.gems_for_template_engine(:erb).should  == ''
    end
  end

  describe "#gems_for_testing_framework" do
    it "should generate DSL for testing framework plugin" do
      @generator.gems_for_testing_framework(:test_unit).should == 'gem "test_unit", :group => :test'
    end

    it "should not generate DSL if we use rspec" do
      @generator.gems_for_testing_framework(:rspec).should  == 'gem "rspec", :group => :test'
    end
  end
end

shared_examples_for "named generator" do

  describe '#file_name' do

    it "should convert the name to snake case" do
      @generator.name = 'SomeMoreStuff'
      @generator.file_name.should == 'some_more_stuff'
    end

    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.file_name.should == "project-pictures"
    end

  end
  
  describe '#base_name' do

    it "should convert the name to snake case" do
      @generator.name = 'SomeMoreStuff'
      @generator.base_name.should == 'some_more_stuff'
    end

    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.base_name.should == "project-pictures"
    end

  end

  describe "#symbol_name" do

    it "should snakify the name" do
      @generator.name = "ProjectPictures"
      @generator.symbol_name.should == "project_pictures"
    end
    
    it "should replace dashes with underscores" do
      @generator.name = "project-pictures"
      @generator.symbol_name.should == "project_pictures"
    end

  end

  describe '#class_name' do
  
    it "should convert the name to camel case" do
      @generator.name = 'some_more_stuff'
      @generator.class_name.should == 'SomeMoreStuff'
    end
    
    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.class_name.should == 'SomeMoreStuff'
    end
  
  end
  
  describe '#module_name' do
  
    it "should convert the name to camel case" do
      @generator.name = 'some_more_stuff'
      @generator.module_name.should == 'SomeMoreStuff'
    end
    
    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.module_name.should == 'SomeMoreStuff'
    end
  
  end
  
  describe '#test_class_name' do
    
    it "should convert the name to camel case and append 'test'" do
      @generator.name = 'some_more_stuff'
      @generator.test_class_name.should == 'SomeMoreStuffTest'
    end
    
  end

end

shared_examples_for "namespaced generator" do

  describe "#class_name" do
    it "should camelize the name" do
      @generator.name = "project_pictures"
      @generator.class_name.should == "ProjectPictures"
    end
    
    it "should split off the last double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.class_name.should == "ProjectPictures"
    end
    
    it "should split off the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.class_name.should == "ProjectPictures"
    end
    
    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.class_name.should == 'SomeMoreStuff'
    end
  end
  
  describe "#module_name" do
    it "should camelize the name" do
      @generator.name = "project_pictures"
      @generator.module_name.should == "ProjectPictures"
    end
    
    it "should split off the last double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.module_name.should == "ProjectPictures"
    end
    
    it "should split off the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.module_name.should == "ProjectPictures"
    end
    
    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.module_name.should == 'SomeMoreStuff'
    end
  end
  
  describe "#modules" do
    it "should be empty if no modules are passed to the name" do
      @generator.name = "project_pictures"
      @generator.modules.should == []
    end
    
    it "should split off all but the last double colon separated chunks" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.modules.should == ["Test", "Monkey"]
    end
    
    it "should split off all but the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.modules.should == ["Test", "Monkey"]
    end
  end
  
  describe "#file_name" do
    it "should snakify the name" do
      @generator.name = "ProjectPictures"
      @generator.file_name.should == "project_pictures"
    end
    
    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.file_name.should == "project-pictures"
    end
    
    it "should split off the last double colon separated chunk and snakify it" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.file_name.should == "project_pictures"
    end
    
    it "should split off the last slash separated chunk and snakify it" do
      @generator.name = "test/monkey/project_pictures"
      @generator.file_name.should == "project_pictures"
    end
  end
  
  describe "#base_name" do
    it "should snakify the name" do
      @generator.name = "ProjectPictures"
      @generator.base_name.should == "project_pictures"
    end
    
    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.base_name.should == "project-pictures"
    end
    
    it "should split off the last double colon separated chunk and snakify it" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.base_name.should == "project_pictures"
    end
    
    it "should split off the last slash separated chunk and snakify it" do
      @generator.name = "test/monkey/project_pictures"
      @generator.base_name.should == "project_pictures"
    end
  end
  
  describe "#symbol_name" do
    it "should snakify the name and replace dashes with underscores" do
      @generator.name = "project-pictures"
      @generator.symbol_name.should == "project_pictures"
    end
    
    it "should split off the last slash separated chunk, snakify it and replace dashes with underscores" do
      @generator.name = "test/monkey/project-pictures"
      @generator.symbol_name.should == "project_pictures"
    end
  end
  
  describe "#test_class_name" do
    it "should camelize the name and append 'Test'" do
      @generator.name = "project_pictures"
      @generator.test_class_name.should == "ProjectPicturesTest"
    end
    
    it "should split off the last double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.test_class_name.should == "ProjectPicturesTest"
    end
    
    it "should split off the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.test_class_name.should == "ProjectPicturesTest"
    end
  end
  
  describe "#full_class_name" do
    it "should camelize the name" do
      @generator.name = "project_pictures"
      @generator.full_class_name.should == "ProjectPictures"
    end
    
    it "should camelize a name with dashes" do
      @generator.name = "project-pictures"
      @generator.full_class_name.should == "ProjectPictures"
    end
    
    it "should leave double colon separated chunks" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.full_class_name.should == "Test::Monkey::ProjectPictures"
    end
    
    it "should convert slashes to double colons and camel case" do
      @generator.name = "test/monkey/project_pictures"
      @generator.full_class_name.should == "Test::Monkey::ProjectPictures"
    end
  end
  
  describe "#base_path" do
    it "should be blank for no namespaces" do
      @generator.name = "project_pictures"
      @generator.base_path.should == ""
    end
    
    it "should snakify and join namespace for double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.base_path.should == "test/monkey"
    end
    
    it "should leave slashes but only use the namespace part" do
      @generator.name = "test/monkey/project_pictures"
      @generator.base_path.should == "test/monkey"
    end
  end

end
