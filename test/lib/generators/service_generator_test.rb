require 'test_helper'

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests ServiceGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination
  teardown :prepare_destination

  test 'doesnt blow up' do
    assert_nothing_raised do
      run_generator ['hella']
    end
  end

  test 'generates a class and test stub correctly' do
    run_generator ['hella']

    assert_file 'app/services/hella_service.rb' do |service|
      assert service.include? 'HellaService < ObjectServices::Base'
    end

    assert_file 'test/services/hella_service_test.rb' do |test|
      assert test.include? 'describe HellaService'
    end
  end

  test 'generates a module::class correctly' do
    run_generator ['super/big_time/hella']
    assert_file 'app/services/super/big_time/hella_service.rb' do |service|
      assert service.include? 'Super::BigTime::HellaService < ObjectServices::Base'
    end
  end

end
