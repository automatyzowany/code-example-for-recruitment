# frozen_string_literal: true

module OrderManager
  # This module will set order of tasks below after other service does his job
  class NewOrder
    include Callable
    
    def initialize(tasks, new_order)
      @tasks = tasks
      @new_order = new_order
    end

    def call
      @tasks.each do |task|
        task.order = @new_order
        task.save
        @new_order += 1
      end
    end
  end
end
