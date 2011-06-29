require 'spec_helper'

describe Merb::Generators::Passenger do

  describe "templates" do
    before :all  do
      @generator = create_generator(Merb::Generators::Passenger, temp_app_name)
    end

    after_generator_spec

    it_should_generate

    it_should_create 'config.ru'

  end

end
