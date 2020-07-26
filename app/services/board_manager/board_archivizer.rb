# frozen_string_literal: true

module BoardManager
  # deciding if board shoud be archived or not
  class BoardArchivizer
    include Callable

    def initialize(board)
      @board = board
    end

    def call
      @board.archived_at.nil? ? @board.soft_archive : @board.unarchive
    end
  end
end
