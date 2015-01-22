class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_service_file
    create_file "app/services/#{name.singularize}_service.rb", <<-FILE
class #{(name.singularize + '_service').classify} < ObjectServices::Base
end
    FILE
  end

  def create_test_file
    create_file "test/services/#{name.singularize}_service_test.rb", <<-FILE
require 'test_helper'

describe #{(name.singularize + '_service').classify} do
end
    FILE
  end

end
