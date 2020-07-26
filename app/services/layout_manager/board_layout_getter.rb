# frozen_string_literal: true

module LayoutManager
  # This module will get the right param group depending on board layout
  class BoardLayoutGetter
    include Callable
    
    def initialize(task, board, params)
      @task = task
      @board = board
      @p = params
    end

    def call
      case @board.board_layout
      when 1
        test_parameters
      when 2
        test2_parameters
      end
    end

    def test_parameters
      @task.name = @p[:name] if @p[:name].present?
      @task.board_id = @p[:board_id] if @p[:board_id].present?
      @task.task_deadline = @p[:task_deadline] if @p[:task_deadline].present?
      @task.task_status = @p[:task_status] if @p[:task_status].present?
      @task.task_group = @p[:task_group] if @p[:task_group].present?
      assigned_users = TaskManager::UserAssigner.call(@p[:assigned])
      @task.assigned = assigned_users if @p[:assigned].present?
      @task.order = order_counter unless @p[:order].nil?
      @task
    end

    def test2_parameters
      @task.name = @p[:name] if @p[:name].present?
      @task.task_deadline = @p[:task_deadline] if @p[:task_deadline]
      @task.task_status = @p[:task_status] if @p[:task_status].present?
      @task.task_group = @p[:task_group] if @p[:task_group].present?
      @task.next_contact = @p[:next_contact] if @p[:next_contact].present?
      @task.last_contact = @p[:last_contact] if @p[:last_contact].present?
      @task.city = @p[:city] if @p[:city].present?
      @task.value = @p[:value] if @p[:value].present?
      @task.contract_size = @p[:contract_size] if @p[:contract_size].present?
      @task.description = @p[:description] if @p[:description].present?
      @task.location = @p[:location] if @p[:location].present?
      @task.responsible_person = @p[:responsible_person] if @p[:responsible_person].present?
      @task.phone = @p[:phone] if @p[:phone].present?
      @task.coop_field = @p[:coop_field] if @p[:coop_field].present?
      @task.liame = @p[:liame] if @p[:liame].present?
      @task.url = @p[:url] if @p[:url].present?
      @task.board_id = @p[:board_id] if @p[:board_id].present?
      assigned_users = TaskManager::UserAssigner.call(@p[:assigned])
      @task.assigned = assigned_users if @p[:assigned].present?
      @task.order = order_counter unless @p[:order].nil?
      @task
    end

    def order_counter
      if @p[:order].present?
        @p[:order] # when task is moved
      else
        OrderManager::OrderMethodChecker.call(@board, @p[:task_group]) # when task is created
      end
    end

    def tasks_with_group_nil?(tasks)
      tasks.count.zero? ? 1 : tasks.last.order + 1
    end

    def layout_class(scope)
      DatabaseManager::ClassGetter.call(scope)
    end
  end
end
