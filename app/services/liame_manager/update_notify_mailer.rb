# frozen_string_literal: true

module LiameManager
  # this module will send email to you when you are assigned to the task
  # and someone will add new update
  class UpdateNotifyMailer
    include Callable
    
    def initialize(board, params)
      @board_layout = board.board_layout
      @p = params
    end

    def call
      UserAssignedTaskMailer.with(
        author_id: @p[:author],
        task_id: @p[:task_id],
        content: @p[:content],
        class_name: @board_layout
      ).new_update_in_task_email.deliver_later
    end
  end
end
