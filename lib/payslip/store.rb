# frozen_string_literal: true

module Payslip
  class Store < Operation
    requires :payslip

    def call
      do_some_magic
    end

    private

    def do_some_magic
      # store in S3
    end
  end
end
