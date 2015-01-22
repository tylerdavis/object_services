require 'test_helper'

class ObjectServicesTest < ActiveSupport::TestCase

  describe '#initialize' do

    describe 'when passing in an object' do
      it 'should initialize a service object' do
        object = {}
        service = ObjectServices::Base.new(object)
        assert service.kind_of? ObjectServices::Base
        service.model.must_be_kind_of Object
        service.errors.must_be_empty
      end

      it 'should initialize with nil passed in' do
        service = ObjectServices::Base.new(nil)
        assert service.kind_of? ObjectServices::Base
        service.model.must_be_nil
        service.errors.must_be_empty
      end
    end

  end

  describe '#create' do
    it 'should create the model if an instance and params are present' do
      mock = MiniTest::Mock.new
      mock.expect(:update, true, [{test: true}])
      mock.expect(:present?, true, [])

      service = ObjectServices::Base.new(mock)
      service.create({test: true})

      assert mock.verify
    end
  end

  describe '#destroy' do

    it 'should destroy the model if the model is present' do
      mock = MiniTest::Mock.new
      mock.expect(:present?, true, [])
      mock.expect(:destroy, true, [])

      service = ObjectServices::Base.new(mock)
      service.destroy

      assert mock.verify
    end

    it 'should return errors if there is no model present' do
      service = ObjectServices::Base.new(nil)
      refute service.destroy
    end

  end

  describe '#update' do

    before do
      class ErrorClass
        def full_messages
          return ['test error message']
        end
      end
      @mock = MiniTest::Mock.new
    end

    it 'should update the model if the model and params are present' do
      @mock.expect(:update, true, [{ test: false }])
      @mock.expect(:present?, true, [])
      service = ObjectServices::Base.new(@mock)
      service.update({ test: false })
      assert @mock.verify
    end

    it 'generates errors if an update fails' do
      @mock.expect(:update, false, [{ test: false }])
      @mock.expect(:present?, true, [])
      @mock.expect(:errors, ErrorClass.new, [])
      service = ObjectServices::Base.new(@mock)
      service.update({ test: false })

      service.errors.must_include 'test error message'

      assert @mock.verify
    end

    it 'generates errors if a model is undefined' do
      @mock.expect(:present?, false, [])
      service = ObjectServices::Base.new(@mock)
      service.update({ test: false })
      service.errors.count.must_equal 1
      service.errors.must_include 'Object not found.'
    end

  end

end