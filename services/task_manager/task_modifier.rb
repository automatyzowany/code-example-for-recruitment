# frozen_string_literal: true

module TaskManager
  # this module will update an existing task
  class TaskModifier
    include Callable
    
    def initialize(params, board, task_id)
      @p = params
      @board = board
      @task = layout_class(@board.board_layout).find(task_id)
      @task_id = task_id
    end

    def call
      task_params = @p[:data][@task_id]
      array_assigned = AssignManager::ArrayAssignator.call(@task.assigned)
      LayoutManager::BoardLayoutGetter.call(@task, @board, task_params)
      @task.save

      param_ids = [@task, @p[:user_id].to_i]
      LiameManager::AssignMailer.new(array_assigned, @task.assigned, param_ids).new_users
      LiameManager::AssignMailer.new(array_assigned, @task.assigned, param_ids).removed_users
      @task
    end

    def layout_class(scope)
      DatabaseManager::ClassGetter.call(scope)
    end
  end
end
