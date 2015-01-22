class ObjectServices::Base

  attr_reader :model, :errors

  # All service-centric errors should extend the ServiceError class.
  class ServiceError < Exception
  end

  # :nodoc:
  def initialize(model)
    @model = model
    @errors = []
  end

  # Update the service's model with a given param object
  # @param [Object] params
  # @return [Boolean] whether the model was updated or not
  def update(params)
    update_model(params)
  end

  # Create a record with a given param object
  # @param [Object] params
  # @return [Boolean] whether the model was created or not
  def create(params)
    update_model(params)
  end

  # Destroys the service's model and clears it
  # @return [Boolean] whether the model was destroyed or not
  def destroy
    if @model.present?
      @model.destroy
      @model = nil
      true
    else
      @errors << self.class.model_not_found
      return false
    end
  end

  private

    # The presence of errors decide whether we will update a model or not.
    # If the final update fails, the service's errors are updated via our model and we return false.
    def update_model(params)
      return false if @errors.any?
      if @model.present?
        if @model.update(params)
          return true
        else
          @errors += @model.errors.full_messages
          return false
        end
      else
        @errors << self.class.model_not_found
        return false
      end
    end

  # returns the parent class of the service
  # Example:  `HellaService` returns `Hella`
  def self.parent_class
    self.name.split('Service').first
  end

  # Resource not found error.
  def self.model_not_found
    "#{parent_class} not found."
  end

end