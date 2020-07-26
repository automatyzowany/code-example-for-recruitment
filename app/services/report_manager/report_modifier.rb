# frozen_string_literal: true

module ReportManager
  # this module will update an existing report
  class ReportModifier
    include Callable

    def initialize(params, report_id)
      @p = params
      @report = Report.find(report_id)
      @report_id = report_id
    end

    def call
      report_params = @p[:data][@report_id]
      LayoutManager::ReportLayoutGetter.call(@report, @p[:report_type], report_params)
      @report.save

      @report
    end
  end
end
