class ProductionController < ApplicationController
  access user: :all, message: 'Nie masz uprawnień.'
  before_action :set_board, only: [:new_task, :create_task, :edit_task, :update_task, :destroy_task, :find_new_assigned_users, :find_removed_assigned_users]
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  include Taskable

  def edit_task
    task_array = params[:id].split(',')
    task_array.each do |task_id|
      TaskManager::TaskModifier.call(params, @board, task_id)
    end
    change_tasks_group(params[:triggeredRow])
    @tasks = layout_class(@board.board_layout).find(task_array)

    respond_to do |format|
      format.json
    end
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = Test.find(params[:id])
  end

  def set_all_tasks
    @tasks = Test.all
  end

  def layout_class(scope)
    DatabaseManager::ClassGetter.call(scope)
  end
end
