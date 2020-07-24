# frozen_string_literal: true

module TimerManager
  # this module will bring selected board tasks into second select if you choose board
  # on timer / index page
  class BoardTasksGetter
    include Callable

    def initialize(element_type)
      @element_type = element_type # board id or mytasks board if 0
      @board = Board.find(@element_type) unless @element_type.to_i.zero?
    end

    def call
      if @element_type.to_i.zero?
        Mytask.not_removed.where(user_id: current_user.id)
      else
        layout_class(@board.board_layout).not_removed.not_archived.where(board_id: @element_type)
      end
    end

    private

    def layout_class(scope)
      DatabaseManager::ClassGetter.call(scope)
    end
  end
end
