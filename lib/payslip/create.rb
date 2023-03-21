# frozen_string_literal: true

module Payslip
  class Create < Operation
    requires :employee, :pay_period, send_email: true

    def call
      calculate_total_earnings
      calculate_total_tax
      calculate_student_loan
      calculate_national_insurance
      calculate_expenses

      generate_payslip
      store_payslip_in_s3
      email_payslip
      send_radar_ping
      context
    end

    private

    def calculate_total_earnings = @context[:total_earnings] = 1000
    def calculate_total_tax = @context[:total_tax] = 200
    def calculate_student_loan = @context[:student_loan] = 50
    def calculate_national_insurance = @context[:national_insurance] = 100
    def calculate_expenses = @context[:expenses] = 75

    def generate_payslip
      @context[:payslip] = Generate.call(**context)
    end

    def store_payslip_in_s3
      Store.call(payslip:)
    end

    def email_payslip
      Email.call(payslip:) if send_email
    end

    def send_radar_ping
      message = 'New payslip available!'
      link = 'https://fac.freeagent.dev/payslips/1'
      ::SendPing.call(employee:, message:, link:)
    end
  end
end
