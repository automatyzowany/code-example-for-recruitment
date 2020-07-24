# frozen_string_literal: true

module TaskManager
  # This module is creating new task
  class TaskCreator
    include Callable

    def initialize(params, board)
      @p = params
      @board = board
    end

    def call
      @task = layout_class(@board.board_layout).new
      task_params = @p[:data]['0']
      LayoutManager::BoardLayoutGetter.call(@task, @board, task_params)
      @task.user_id = @p[:user_id]
      return false unless @task.save
      
      param_ids = [@task, @p[:user_id].to_i]
      LiameManager::AssignMailer.new([], @task.assigned, param_ids).new_users
      @task
    end

    def layout_class(scope)
      DatabaseManager::ClassGetter.call(scope)
    end
  end
end
