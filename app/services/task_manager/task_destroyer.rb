# frozen_string_literal: true

module TaskManager
  # This Service will soft delete a task with all dependencies
  class TaskDestroyer
    include Callable

    def initialize(params, board)
      @p = params
      @board = board
    end

    def call
      task_array = @p[:id].split(',')
      tasks = layout_class(@board.board_layout).where(id: task_array)
      tasks.each do |task|
        destroy_updates(task.id)
        task.soft_delete
      end
      tasks_in_board = layout_class(@board.board_layout).tasks_in_board(@board.id)
      OrderManager::NewOrder.call(tasks_in_board, 1)
    end

    def destroy_updates(id)
      updates = Update.not_removed.where(task_id: id)
      updates.map(&:soft_delete)
    end

    def layout_class(scope)
      DatabaseManager::ClassGetter.call(scope)
    end
  end
end
