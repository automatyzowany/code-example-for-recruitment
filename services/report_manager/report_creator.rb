# frozen_string_literal: true

module ReportManager
  # this module will add new report
  class ReportCreator
    include Callable

    def initialize(params)
      @p = params
      @report_type = @p[:report_type]
    end

    def call
      @report = Report.new
      report_params = @p[:data]['0']
      LayoutManager::ReportLayoutGetter.call(@report, @report_type.to_i, report_params)
      return false unless @report.save

      @report
    end
  end
end
