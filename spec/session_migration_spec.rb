require 'spec_helper'

describe Merb::Generators::SessionMigration do

  describe "templates" do

    before :all do
      @generator = create_generator(Merb::Generators::SessionMigration, temp_app_name)
    end

    after_generator_spec

    it_should_generate

    it "should spec stuff"

  end

end
