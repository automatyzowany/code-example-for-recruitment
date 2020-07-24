# frozen_string_literal: true

module DatabaseManager
  # This Service will soft delete a task with all dependencies
  class ClassGetter
    include Callable
    
    CLASS_BY_LAYOUT = { '1' => Test, '2' => Test2 }.freeze

    def initialize(scope)
      @scope = scope
    end

    def call
      CLASS_BY_LAYOUT[@scope.to_s]
    end
  end
end
