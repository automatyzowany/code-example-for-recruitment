# frozen_string_literal: true

module AssignManager
  # this module will get already assigned people
  class ArrayAssignator
    include Callable
    
    def initialize(array)
      @array = array
    end

    def call
      @array.nil? ? [] : @array
    end
  end
end
