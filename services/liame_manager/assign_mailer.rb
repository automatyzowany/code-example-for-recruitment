# frozen_string_literal: true

module LiameManager
  # This module will send email with notification when person is assigned
  class AssignMailer
    
    def initialize(array, task_array, param_ids)
      @array = array
      @task_array = task_array
      @param_ids = param_ids
      @board = Board.find(@param_ids[0].board_id)
    end

    def new_users
      difference = @task_array - @array
      difference.each do |id|
        @user = User.find(id)
        UserAssignedTaskMailer.with(
          user: @user,
          task_id: @param_ids[0].id,
          class_name: @board.board_layout
        ).user_assigned_email.deliver_later
        NotifManager::NotifCreator.new(@param_ids, 1, @user).task_notif
      end
    end

    def removed_users
      difference = @array - @task_array
      difference.each do |id|
        @user = User.find(id)
        UserAssignedTaskMailer.with(
          user: @user,
          task_id: @param_ids[0].id,
          class_name: @board.board_layout
        ).user_unassigned_email.deliver_later
        NotifManager::NotifCreator.new(@param_ids, 2, @user).task_notif
      end
    end
  end
end
