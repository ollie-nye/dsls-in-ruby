# frozen_string_literal: true

require 'stringio'

module Payslip
  class Generate < Operation
    requires :employee, :pay_period, :total_earnings, :total_tax, :student_loan,
             :national_insurance, :expenses

    def call
      do_some_magic
    end

    private

    def do_some_magic
      @context[:pdf] = StringIO.new
    end
  end
end
