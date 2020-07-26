# frozen_string_literal: true

module OrderManager
  # This module is checking which order method should be used
  class OrderMethodChecker
    include Callable
    
    def initialize(board, task_group = nil)
      @board = board
      @task_group = task_group if task_group.present?
    end

    def call
      tasks = layout_class(@board.board_layout).tasks_in_board(@board.id)
      if @task_group.present? && tasks.count.positive?
        tasks_with_group = tasks.where(task_group: @task_group)
        task_order = tasks_with_group_nil?(tasks_with_group)
        OrderManager::NewOrder.call(tasks.after_adding_task(task_order), task_order + 1)
      else
        task_order = 1
        OrderManager::NewOrder.call(tasks, 2)
      end
      task_order
    end

    def layout_class(scope)
      DatabaseManager::ClassGetter.call(scope)
    end

    def tasks_with_group_nil?(tasks)
      tasks.count.zero? ? 1 : tasks.last.order + 1
    end
  end
end
