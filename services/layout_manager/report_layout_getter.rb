# frozen_string_literal: true

module LayoutManager
  # This module will get the right param group depending on report layout
  class ReportLayoutGetter
    include Callable
    
    def initialize(report, report_type, params)
      @report = report
      @report_type = report_type.to_i
      @p = params
    end

    def call
      case @report_type
      when 1
        production_parameters
      when 2
        sale_parameters
      end
    end

    def production_parameters
      @report.name = @p[:name] if @p[:name]
      @report.client_type = @p[:client_type] if @p[:client_type]
      @report.report_status = @p[:report_status] if @p[:report_status].present?
      @report.report_phase = @p[:report_phase] if @p[:report_phase].present?
      @report.report_group = @p[:report_group] if @p[:report_group].present?
      @report.report_type = @report_type if @report_type.present?
      @report.priority_one = @p[:priority_one] if @p[:priority_one]
      @report.priority_two = @p[:priority_two] if @p[:priority_two]
      @report.planned_ending = @p[:planned_ending] if @p[:planned_ending]
      @report.contract_size = @p[:contract_size] if @p[:contract_size]
      @report.contract_paid = @p[:contract_paid] if @p[:contract_paid]
      @report.contract_left = contract_left
      @report.contract_cost = @p[:contract_cost] if @p[:contract_cost]
      @report.contract_start_date = @p[:contract_start_date] if @p[:contract_start_date]
      @report.advance_payment_date = @p[:advance_payment_date] if @p[:advance_payment_date]
      @report.contract_end_date = @p[:contract_end_date] if @p[:contract_end_date]
      @report.url = @p[:url] if @p[:url]
      @report.firmao_id = @p[:firmao_id] if @p[:firmao_id]

      assigned_users = AssignManager::PeopleAssignator.call(@p[:assigned])
      assigned_sellers = AssignManager::PeopleAssignator.call(@p[:sellers])
      @report.assigned = assigned_users if assigned_users.present?
      @report.sellers = assigned_sellers if assigned_sellers.present?
      @report.order = order_counter unless @p[:order].nil?
      @report
    end

    def sale_parameters
      @report.name = @p[:name] if @p[:name]
      @report.client_type = @p[:client_type] if @p[:client_type]
      @report.report_status = @p[:report_status] if @p[:report_status].present?
      @report.report_phase = @p[:report_phase] if @p[:report_phase].present?
      @report.report_group = @p[:report_group] if @p[:report_group].present?
      @report.report_type = @report_type if @report_type.present?
      @report.priority_one = @p[:priority_one] if @p[:priority_one]
      @report.priority_two = @p[:priority_two] if @p[:priority_two]
      @report.planned_ending = @p[:planned_ending] if @p[:planned_ending]
      @report.contract_size = @p[:contract_size] if @p[:contract_size]
      @report.contract_paid = @p[:contract_paid] if @p[:contract_paid]
      @report.contract_left = @p[:contract_left] if @p[:contract_left]
      @report.contract_cost = @p[:contract_cost] if @p[:contract_cost]
      @report.contract_start_date = @p[:contract_start_date] if @p[:contract_start_date]
      @report.advance_payment_date = @p[:advance_payment_date] if @p[:advance_payment_date]
      @report.contract_end_date = @p[:contract_end_date] if @p[:contract_end_date]

      assigned_users = AssignManager::PeopleAssignator.call(@p[:assigned])
      assigned_sellers = AssignManager::PeopleAssignator.call(@p[:sellers])
      @report.assigned = assigned_users if assigned_users.present?
      @report.sellers = assigned_sellers if assigned_sellers.present?
      @report.order = order_counter unless @p[:order].nil?
      @report
    end

    def order_counter
      if @p[:order].present?
        @p[:order] # when task is moved
      else
        OrderManager::OrderMethodReportChecker.call(@report, @p[:report_group]) # when task is created
      end
    end

    def contract_left
      contract_size = 0 if @report.contract_size.blank?
      contract_paid = 0 if @report.contract_paid.blank?
      contract_left = contract_size.to_i - contract_paid.to_i
      contract_left
    end
  end
end
