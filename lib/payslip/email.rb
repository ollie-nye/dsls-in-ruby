# frozen_string_literal: true

module Payslip
  class Email < Operation
    requires :payslip

    def call
      do_some_magic
    end

    private

    def do_some_magic
      # send an email
    end
  end
end
