module Errors
  class InvalidParametersError < StandardError
    def initialize(mandatory_params = [], optional_params = [])
      @mandatory_params = mandatory_params
      @optional_params = optional_params
    end

    def message
      "Invalid Parameters." + (
        @mandatory_params.size > 0 ?
        " Mandatory parameters: #{@mandatory_params}." : ''
      ) + (
        @optional_params.size > 0 ?
        " Optional parameters: #{@optional_params}." : ''
      )
    end
  end
end