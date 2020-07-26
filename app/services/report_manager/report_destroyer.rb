# frozen_string_literal: true

module ReportManager
  # this module will destroy report
  class ReportDestroyer
    include Callable

    def initialize(params)
      @p = params
    end

    def call
      report_array = @p[:id].split(',')
      reports = Report.where(id: report_array)
      reports.each do |report|
        destroy_updates(report.id)
        report.soft_delete
      end
      reports_in_board = Report.reports_in_board(@p[:report_type])
      OrderManager::NewOrder.call(reports_in_board, 1)
    end

    def destroy_updates(report_id)
      updates = ReportUpdate.not_removed.where(report_id: report_id)
      updates.map(&:soft_delete)
    end
  end
end
