# frozen_string_literal: true

module Boards
  # this module will show you the list of boards, you have access to
  class BoardsWithAccessQuery
    include Callable

    def initialize(relation = Board.all, current_user)
      @relation = relation
      @current_user = current_user
    end

    def call
      board_array = []
      @relation.each do |board|
        if board.assigned.include? @current_user.id.to_s || board.board_type == 'publiczna'
          board_array << board.id
        end
      end
      Board.where(id: board_array).not_removed.unarchived
    end
  end
end
