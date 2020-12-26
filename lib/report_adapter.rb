# frozen_string_literal: true

# https://developer.github.com/v3/checks/runs/#output-object
class ReportAdapter
  class << self
    CONCLUSION_TYPES = { failure: 'failure', success: 'success' }.freeze
    ANNOTATION_LEVEL = { notice: 'notice', warning: 'warning', failure: 'failure' }.freeze

    def conslusion(report)
      lines_covered_percent(report) >= lines_minimum_percent(report).to_f ? CONCLUSION_TYPES[:success] : CONCLUSION_TYPES[:failure]
    end

    def summary(report)
      "**Coverage**:\n\n#{table_head}\n| Lines | #{lines_covered_percent(report)}%     | #{lines_minimum_percent(report)}%     |\n"
    end

    def summary_per_file(report)
      res = String.new ""
      res << "\n\n#{per_file_table_head}\n"
      for n in report['per_file']
        res << "| #{n['file']} | #{n['lines']} | #{n['covered_lines']} | #{n['coverage']}% |\n"
      end
      res
    end

    def annotations(_report)
      []
    end

    def lines_covered_percent(report)
      @lines_covered_percent ||= report.dig('lines', 'covered_percent')
    end

    private

    def table_head
      "| Type  | covered | minimum |\n| ----- | ------- | ------- |"
    end

    def per_file_table_head()
      "| File | lines | covered lines | coverage |\n| ---- | ----- | ------------- | -------- |"
    end

    def lines_minimum_percent(report)
      @lines_minimum_percent ||= report.dig('lines', 'minumum_percent')
    end
  end
end
