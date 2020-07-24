# frozen_string_literal: true

module OrderManager
  # This module is checking which order method should be used
  class OrderMethodReportChecker
    include Callable

    def initialize(report, report_group = nil)
      @report = report
      @report_group = report_group if report_group.present?
    end

    def call
      reports = Report.reports_in_board(@report.report_type)
      if @report_group.present? && reports.count.positive?
        reports_with_group = reports.where(report_group: @report_group)
        report_order = tasks_with_group_nil?(reports_with_group)
        OrderManager::NewOrder.call(reports.after_adding_task(report_order), report_order + 1)
      else
        report_order = 1
        OrderManager::NewOrder.call(reports, 2)
      end
      report_order
    end

    def tasks_with_group_nil?(tasks)
      tasks.count.zero? ? 1 : tasks.last.order + 1
    end
  end
end
