class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def not_found
    {
      errors: [
        {
          status: "404",
          title: @error.message
        }
      ]
    }
  end

  def self.not_created(errors)
    {
      errors: errors.full_messages.map do |message|
        {
          status: "406",
          title: message
        }
      end
    }
  end

  # Returns a hash representing the error message for missing strong parameters.
  #
  # @return [Hash] The error message hash.
  def self.invalid_strong_params
    {
      error: "You must update a destination using one of the following formats",
      acceptable_formats: [
        { destination: { valid_attribute: "new_attributes" } },
        { valid_attribute: "new_attributes" }
      ]
    }
  end

  def self.invalid_patch(error)
    {
      errors: [
        {
          status: "406",
          title: error.message
        }
      ]
    }
  end
end
